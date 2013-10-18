ActiveAdmin.register Op do

  controller do
    defaults :finder => :find_by_slug

    def permitted_params
      params.permit(:op => [:name, :content, :tag_list, :avatar, :links_attributes => [:link, :_destroy, :id]])
    end
  end

  filter :name

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "OP Details" do
      f.input :name
      f.input :content
      f.input :tag_list
      f.input :avatar
    end

    f.inputs do
      f.has_many :links, :allow_destroy => true do |cf|
        cf.input :link
      end
    end

    f.buttons
  end

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
      row :links do
        op.links.map{|l| link_to l.site, l.link }.join("<br />").html_safe
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
