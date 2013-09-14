namespace :migrate do

  # Populate taggings new karma column
  task :add_karma_to_taggings => :environment do
    Tagging.all.each do |tagging|
      if tagging.taggable_type == 'Op'
        op = Op.find(tagging.taggable_id)
        tagging.update_attribute(:karma, op.comment_karma)
      elsif tagging.taggable_type == 'Ama'
        ama = Ama.find(tagging.taggable_id)
        tagging.update_attribute(:karma, ama.karma)
      end
    end
  end

  # Add Auto Taggings to an AMA
  task :add_taggings => :environment do
    require 'api/alchemyapi.com'
    @ama = Ama.order('RANDOM()').first
    puts @ama.title
    a = AlchemyApi.new()
    response = a.TextGetRankedKeywords(@ama.title)
    blacklist  = ['ama', 'iama', 'amaa']
    tags = response['keywords'].map{|k| k['text'].downcase.split.delete_if{|x| blacklist.include?(x)}.join(' ')}
    if tags.count > 0
      puts "Original: #{@ama.tag_list}"
      @ama.tag_list.add(tags)
      puts "Finished: #{@ama.tag_list}"
    else
      @ama.tag_list.add("none")
    end
  end
end
