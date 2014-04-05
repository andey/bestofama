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


  # Make all comments Relevant
  task :make_all_comments_relevant => :environment do
    Comment.update_all(relevant: true)
  end

    # Make all comments Relevant
  task :mark_all_relevant_children_comments => :environment do
    Comment.where(relevant: true).each do |c|
      if c.relevant_children.count > 0
        puts c.id
        c.update_attribute(:relevant_child, true)
      end
    end
  end
end
