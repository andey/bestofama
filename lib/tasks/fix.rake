namespace :fix do

  # Correct all "/r/subreddit" internal links within comments
  task :correct_reddit_relative_links => :environment do
    Comment.all.each do | comment |
      matches = comment.content.match(/href="(\/r\/[a-zA-Z0-9]*)"/)
      if matches
        ap comment
        fixed_content = comment.content.gsub('href="' + matches[1], 'href="http://www.reddit.com' + matches[1])
        comment.update_attribute(:content, fixed_content)
      end
    end
  end
end