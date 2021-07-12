class CarsController < ApplicationController
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

  private

  def car_params
    params.require(:car).permit(
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
end
