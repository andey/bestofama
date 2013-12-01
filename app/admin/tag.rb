ActiveAdmin.register Tag do
  actions :all, :except => [:destroy, :new]

  filter :name
  filter :description

  scope :popular, default: true
  scope :all

  #batch_action :merge do |selection|
  #  Tag.find(selection).each do |post|
  #    puts post.name
  #  end
  #  redirect_to :back
  #end

  controller do
    def permitted_params
      params.permit(:tag => [:name, :description, :wikipedia_url, :meaningless, :image_source, :redirect_tag_name])
    end
  end

  index do
    #selectable_column
    column do |t|
      if t.image.exists?
        image_tag(t.image.url(:thumb), style: 'width: 75px;')
      end
    end
    column do |t|
      link_to t.name, tag_path(t.name), target: '_blank'
    end
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
      f.input :redirect_tag_name
    end

    f.actions do
      f.action :submit
      f.action :cancel
    end
  end
end
