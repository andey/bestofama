ActiveAdmin.register Archive do
  actions :index

  config.filters = false

  index do
    column :created_at
    column :ama
  end
  
end
