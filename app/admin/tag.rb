ActiveAdmin.register Tag do
  filter :name
  filter :description

  controller do
    def permitted_params
      params.permit(:tag => [:name, :description, :wikipedia_url, :meaningless])
    end
  end
end
