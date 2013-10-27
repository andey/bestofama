module NestedUser
  def users_attributes=(users)
    users.values.each do |params|
      user = User.find_or_create_by(username: params[:username])
      params[:_destroy].to_i == 1 ? self.remove_user(user) : self.add_user(user)
    end
  end

  # Add an user to model
  def add_user(user)
    self.users << user unless self.users.include?(user)
  end

  # Remove user from model
  def remove_user(user)
    self.users.destroy(user)
  end
end