ActiveAdmin.register Metum do
  controller do
    def permitted_params
      params.permit(:metum => [:name, :value])
    end
  end
end
