ActiveAdmin.register Comment, :as => "AmaComment" do

  filter :ama_id
  filter :key
  filter :user_id
  filter :parent_key
  filter :relevant

  index do
    column :ama
    column :key
    column :user
    column :karma
    column :date
    column :relevant
    default_actions
  end

end
