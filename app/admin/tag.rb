ActiveAdmin.register Tag do
  actions :all, :except => [:destroy, :new]

  filter :name
  filter :description

  scope :popular, default: true
  scope :all

  controller do
    def permitted_params
      params.permit(:tag => [:name, :description, :wikipedia_url, :meaningless, :image_source])
    end
  end

  index do
    column :name
    column :description
    column :count_all
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "OP Details" do
      f.input :name
      f.input :wikipedia_url
      f.input :description
      f.input :image_source
    end

    f.actions do
      f.action :submit
      f.action :cancel
    end
  end
end
