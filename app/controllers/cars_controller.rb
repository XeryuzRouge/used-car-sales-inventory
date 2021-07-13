class CarsController < ApplicationController
  before_action :admin?, only: [:create, :destroy]
  before_action :logged_in?, only: [:index]

  def index
    @cars = Car.all
    render json: @cars
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      render created
    else
      render bad_request(missing_params)
    end
  end

  def destroy
    Car.find_by(id: params[:id]).destroy
    render ok
  end

  private

  def car_params
    params.require(:car).permit(
      :id,
      :brand,
      :model,
      :monetary_price,
      :type,
      dealerships: []
    )
  end

  def created
    { status: 201 }
  end

  def ok
    { status: 200 }
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
    @car.errors.messages.each do |param, message|
      errors << { "param": param, "message": message.join(',') }
    end

    { "errors": errors }
  end

  def admin?
    return if helpers.current_user.role == 'admin'

    render json: { message: 'only admins can do this action' }, status: :unauthorized
  end

  def logged_in?
    return if helpers.logged_in?

    render json: { message: 'please log in' }, status: :unauthorized
  end
end
