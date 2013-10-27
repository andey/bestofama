module NestedAttributes
  def users_attributes=(users)
    users.values.each do |params|
      user = User.find_or_create_by(username: params[:username])
      params[:_destroy].to_i == 1 ? self.remove_user(user) : self.add_user(user)
    end
  end
end