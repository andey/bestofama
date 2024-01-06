Rails.application.routes.draw do
  instance_eval(File.read(Rails.root.join("config/routes/public.rb")))
  instance_eval(File.read(Rails.root.join("config/routes/reroute.rb")))
end
