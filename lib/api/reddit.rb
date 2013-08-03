#== Reddit.com API library

module Reddit
  require "net/http"
  require 'open-uri'
  require 'override/json'
  require 'htmlentities'

  class << self

    # generic http GET request, parses json.
    # returns json
    def get(url)
      http = Net::HTTP.new("www.reddit.com")
      request = Net::HTTP::Get.new(url)
      request.add_field('User-Agent', 'bestofama.com / andey@reddit.com')
      response = http.request(request)
      return JSON.parse(response.read_body)
    end

    # generic http POST request, parses json.
    # returns json
    def post(url, query)
      http = Net::HTTP.new("www.reddit.com")
      request = Net::HTTP::Post.new(url)
      request.add_field('User-Agent', 'bestofama.com / andey@reddit.com')
      request.set_form_data(query)
      response = http.request(request)
      return JSON.parse(response.read_body)
    end

    # Will return user if found, else
    # create user and then return user
    # returns user
    def find_user(username)
      user = User.find_by_username(username)
      if user
        return user
      else
        return User.create(:username => username)
      end
    end

    # Creates an AMA record.
    # Expects the record "data" from reddit.com api json.
    # returns ama
    def save_ama(ama_json)
      data = {
          :key => ama_json["id"],
          :date => Time.at(ama_json["created_utc"]),
          :title => ama_json["title"].to_s.truncate(250, :omission => "..."),
          :karma => ama_json["score"],
          :user_id => find_user(ama_json["author"]).id,
          :permalink => ama_json["permalink"],
          :content => HTMLEntities.new.decode(ama_json["selftext_html"]),
          :comments => ama_json["num_comments"],
          :responses => 0
      }
      return Ama.create(data)
    end

    # Creates the original AMA record.
    # It does not fetch the comments.
    # Comments are fetched on a rake cronjob
    # returns ama
    def create_ama(key)
      begin
        result = get("http://www.reddit.com/by_id/t3_" + key + ".json")
        puts result
        ama_json = result["data"]["children"][0]["data"]
        op_username = result["data"]["children"][0]["data"]["author"]
        op_user = find_user(op_username)

        data = {
            :key => key,
            :date => Time.at(ama_json["created_utc"]),
            :title => ama_json["title"].to_s.truncate(250, :omission => "..."),
            :karma => ama_json["score"],
            :user_id => op_user.id,
            :permalink => ama_json["permalink"],
            :content => HTMLEntities.new.decode(ama_json["selftext_html"]),
            :comments => ama_json["num_comments"],
            :responses => 0
        }
        return Ama.create(data)
      rescue
        return false
      end
    end

    # updates an AMA record
    def update_ama(ama, json)

      #The sum of OP & Participant comments
      op_responses = Comment.where(:ama_id => ama.id, :user_id => ama.user.id).count
      participants_responses = Comment.where(:ama_id => ama, :user_id => ama.users).count
      responses = op_responses + participants_responses

      if responses == 0
        responses = -1
      end

      ama.update_attributes(
          :karma => json["score"],
          :content => HTMLEntities.new.decode(json["selftext_html"]),
          :comments => json["num_comments"],
          :responses => responses
      )
    end

    # populates an AMA
    # adds new comments
    def populate_ama(ama)
      result = get("http://www.reddit.com/comments/" + ama.key + ".json")
      ama_json = result[0]["data"]["children"][0]["data"]
      posts_json = result[1]["data"]["children"]

      find_op_responses(ama, posts_json, '-')
      update_ama(ama, ama_json)
    end

    # Recursive function, which selects and saves relevant responses.
    def find_op_responses(ama, posts, depth)

      has_op_child = false

      posts.each do |post|

        if post["kind"] != "more"

          keep_post = false
          is_op = false

          if post["data"]["author"] == ama.user.username
            is_op = true
          elsif ama.users.any? { |u| u.username == post["data"]["author"] }
            is_op = true
          end

          begin
            if post["data"].has_key?("replies") and post["data"]["replies"] != ''
              keep_post = find_op_responses(ama, post["data"]["replies"]["data"]["children"], depth + '-')
            end
          end

          if keep_post || is_op
            has_op_child = true
            comment = Comment.find_by_key(post["data"]["id"])
            if comment
              update_comment(comment, post["data"])
              puts depth + ' [' + post["data"]["author"] + '] UPDATED'
            else
              save_comment(ama.id, post["data"])
              puts depth + ' [' + post["data"]["author"] + '] SAVED'
            end
          else
            puts depth + ' ' + post["data"]["author"]
          end
        end
      end

      return has_op_child
    end


    # saves an AMA comment
    # return comment
    def save_comment(ama_id, post)
      current_user = find_user(post["author"])
      parent_key = /_(.*)/.match(post["parent_id"])[1]
      data = {
          :ama_id => ama_id,
          :key => post["id"],
          :user_id => current_user.id,
          :content => HTMLEntities.new.decode(post["body_html"]),
          :parent_key => parent_key,
          :date => Time.at(post["created_utc"]),
          :karma => post["ups"].to_i - post["downs"].to_i
      }

      comment = Comment.create(data)
      return comment
    end

    # update an AMA comment
    # return comment
    def update_comment(comment, post)
      data = {
          :content => HTMLEntities.new.decode(post["body_html"]),
          :date => Time.at(post["created_utc"]),
          :karma => post["ups"].to_i - post["downs"].to_i
      }
      comment.update_attributes(data)
      return comment
    end
  end
end
