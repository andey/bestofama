namespace :fix do

  # Correct all "/r/subreddit" internal links within comments
  task :correct_reddit_relative_links => :environment do
    Comment.all.each do |comment|
      matches = comment.content.match(/href="(\/r\/[a-zA-Z0-9]*)"/)
      if matches
        ap comment
        fixed_content = comment.content.gsub('href="' + matches[1], 'href="http://www.reddit.com' + matches[1])
        comment.update_attribute(:content, fixed_content)
      end
    end
  end

  # Correct all AMA response counts
  task :correct_ama_responses_counts => :environment do
    Ama.all.each do |ama|
      puts "==============="
      puts ama.id
      puts ama.title
      op_responses = Comment.where(:ama_id => ama.id, :user_id => ama.user.id).count
      participants_responses = Comment.where(:ama_id => ama, :user_id => ama.users).count
      sum = op_responses + participants_responses
      ama.update_attribute(:responses, sum)
    end
  end

end