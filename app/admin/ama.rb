ActiveAdmin.register Ama do

  controller do
    defaults :finder => :find_by_key
  end

  filter :title

  index do
    column :karma
    column :title
    column :created_at
    column :updated_at
    default_actions
  end

end
