class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render created
    else
      render bad_request(missing_params)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :role
    )
  end

  def created
    { status: 201 }
  end

  def bad_request(content)
    {
      status: 400,
      content_type: 'application/json',
      json: content
    }
  end

  def missing_params
    errors = []
    @user.errors.messages.each do |param, message|
      errors << { "param": param, "message": message.join(',') }
    end

    { "errors": errors }
  end
end
