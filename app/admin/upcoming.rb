ActiveAdmin.register Upcoming do

  filter :date
  filter :title
  filter :description

  index do
    column :date
    column :title
    column :description
    column :created_at
    default_actions
  end

end
