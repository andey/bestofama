ActiveAdmin.register Comment, :as => "AmaComment" do

  filter :ama_id
  filter :key
  filter :user_id
  filter :parent_key

  index do
    column :ama_id
    column :key
    column :user
    column :karma
    column :date
    default_actions
  end

end
