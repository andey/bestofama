ActiveAdmin.register Op do

  controller do
    defaults :finder => :find_by_slug
  end

  filter :name

  index do
    column :name
    column :content
    column :updated_at
    column :wikipedia_hits
    column :comment_karma
    default_actions
  end

end
