ActiveAdmin.register Ama do

  actions :all, :except => [:destroy]

  action_item :only => :show do
    link_to 'Public', ama
  end

  action_item :only => :show do
    link_to 'Trash', trash_admin_ama_path, method: :delete
  end

  action_item :only => :show do
    link_to 'Fetch', fetch_admin_ama_path, method: :get
  end

  member_action :trash, :method => :delete do
    ama = Ama.find_by_key(params[:id])
    ama.trash()
    redirect_to admin_amas_path
  end

  member_action :fetch, :method => :get do
    ama = Ama.find_by_key(params[:id])
    ama.fetch()
    redirect_to admin_ama_path(ama)
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    if controller.action_name == 'new'
      f.inputs "Reddit Key" do
        f.input :key
      end
    else
      f.inputs "Tag List" do
        f.input :tag_list
      end
      f.inputs "Participants" do
        f.has_many :users, :allow_destroy => true do |u|
          u.input :username
        end
      end
    end
    f.actions do
      f.action :submit
      f.action :cancel
    end
  end

  controller do
    defaults :finder => :find_by_key

    def permitted_params
      params.permit(:ama => [:tag_list, :users_attributes => [:username, :_destroy, :id]])
    end

    def create
      ap params[:ama]
      @ama = Ama.new(params[:ama].permit(:key))
      @ama.fetch()
      redirect_to admin_ama_path(@ama.key)
    end
  end

  show do |ama|
    attributes_table do

      row :date
      row :title
      row :content do
        ama.content.html_safe
      end
      row :tag_list
      row :op do
        link_to ama.user.username, new_admin_op_path(username: ama.user.username, title: ama.title)
      end
      row :participants do
        ama.users.map { |u| link_to u.username, new_admin_op_path(username: u.username, title: ama.title) }.join(", ").html_safe
      end
      row :karma
      row :permalink
      row :created_at
      row :updated_at
      row :comments
      row :responses
      row :id
      row :key
    end
    active_admin_comments
  end

  scope :queue, default: true
  scope :tagless
  scope :opless
  scope :responseless
  scope :all

  filter :title

  index do
    column :karma
    column :title
    column :responses
    column :created_at
    column :updated_at
    default_actions
  end


end
