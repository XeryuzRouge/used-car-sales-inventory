class ApplicationController < ActionController::Base
  def current_user
    @current_user ||=
      User.first_or_create!(username: 'daniel', password: 'password', role: 'admin')
  end
end
