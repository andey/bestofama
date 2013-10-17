ActiveAdmin.register Op do

  controller do
    defaults :finder => :find_by_slug

    def permitted_params
      params.permit(:op => [:name, :content, :tag_list, :avatar])
    end
  end

  filter :name

  form :partial => 'new'

  index do
    column :name
    column :content
    column :updated_at
    column :wikipedia_hits
    column :comment_karma
    default_actions
  end

  show do |op|
    attributes_table do
      if op.avatar.exists?
        row :avatar do
          image_tag op.avatar.url(:medium)
        end
      end
      row :id
      row :name
      row :content
      row :users do
        op.users.map{|u| link_to u.username, admin_user_path(u)}.join(", ").html_safe
      end
      row :created_at
      row :updated_at
      row :slug
      row :wikipedia_hits
      row :link_karma
      row :comment_karma
    end
    active_admin_comments
  end

end
