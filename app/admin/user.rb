ActiveAdmin.register User do

  controller do
    def permitted_params
      params.permit(:user => [:username, :comment_karma, :link_karma])
    end
  end

  controller do
    defaults :finder => :find_by_username
  end

  filter :username

  index do
    column :username
    column :comment_karma
    column :link_karma
    column :created_at
    column :updated_at
    default_actions
  end

end
