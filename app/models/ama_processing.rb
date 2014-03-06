module AmaProcessing

  # Fetch AMA JSON from Reddit API
  def fetch
    begin
      reddit = Reddit.new
      response = reddit.getAMA(self.key)
      self.process_it(response) if response
    end
  end

  # Recursive function, which selects and saves relevant responses.
  def find_responses(posts)
    relevant = false

    posts.each do |post|
      if post["kind"] != "more"
        if (self.comment_has_children?(post["data"]) || self.is_op?(post["data"]["author"]))
          relevant = true
          self.find_or_create_comment_by_json(post["data"], true)
        else
          self.find_or_create_comment_by_json(post["data"], false)
        end
      end
    end

    return relevant
  end

  # Creates an AMA record.
  # Expects the record "data" from reddit.com api json.
  # returns ama
  def create_by_json(json)
    puts '-------------------'
    puts 'CREATE BY JSON'
    puts json
    self.attributes = {
        :key => json["id"],
        :date => Time.at(json["created_utc"]),
        :title => json["title"].to_s.truncate(250, :omission => "..."),
        :karma => json["score"],
        :user_id => User.find_or_create_by(username: json["author"]).id,
        :permalink => json["permalink"],
        :content => HTMLEntities.new.decode(json["selftext_html"]),
        :comments => json["num_comments"],
        :responses => 0
    }
    return self.save ? self : false
  end

  # Updates an AMA from Reddit AMA JSON
  def update_by_json(json)

    #The sum of OP & Participant comments
    op_responses = Comment.where(:ama_id => self, :user_id => self.user).count
    participants_responses = Comment.where(:ama_id => self, :user_id => self.users).count
    responses = op_responses + participants_responses

    if responses == 0
      responses = -1
    end

    self.update_attributes(
        :karma => json["score"],
        :content => HTMLEntities.new.decode(json["selftext_html"]),
        :comments => json["num_comments"],
        :responses => responses
    )
  end

  # Find or Create comment from Reddit JSON
  def find_or_create_comment_by_json(data, relevant)
    comment = Comment.find_by_key(data["id"])
    if comment
      comment.update_by_json(data, relevant)
    else
      comment = Comment.new
      comment.create_by_json(self.id, data, relevant)
    end
  end

  # Should this comment be saved?
  def comment_has_children?(data)
    if data.has_key?("replies") and data["replies"] != ''
      return self.find_responses(data["replies"]["data"]["children"])
    else
      return false
    end
  end

  # Process JSON response
  def process_it(response)
    self.archive_it(response)
    self.update_or_create(response)
  end
 
  # Should the AMA be 
  # updated or created?
  def update_or_create(response)
    if self.date
      self.find_responses(response[1]["data"]["children"])
      self.update_by_json(response[0]["data"]["children"][0]["data"])
    else
      self.create_by_json(response[0]["data"]["children"][0]["data"])
      self.find_responses(response[1]["data"]["children"])
    end
  end

  # Archive the AMA response
  def archive_it(response)
    Archive.create(ama_id: self.id, json: response[0]) rescue "Failed to Archive AMA #{self.key}"
  end

end
