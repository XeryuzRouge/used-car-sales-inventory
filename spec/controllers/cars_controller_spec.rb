require 'rails_helper'

RSpec.describe CarsController do
  before do
    allow(controller).to receive(:logged_in?).and_return(true)
    allow(controller).to receive(:admin?).and_return(true)
  end

  describe 'POST #create' do
    it 'returns http success when car is created' do
      params = {
        brand: 'brand',
        model: '2001',
        monetary_price: 12_345,
        new: true,
        dealerships: %w[one two three]
      }

      post :create, params: { car: params }

      expect(response).to have_http_status(:created)
      expect(response.status_message).to eq('Created')
      expect(response.body).to be_blank

      car = Car.last
      expect(car.dealerships).to eq(params[:dealerships])
    end
  end

  describe 'GET #index' do
    it 'gives all the cars registered' do
      create_car('Volkswagen', '2009', 23_232, false, ['one'])
      create_car('Ford', '1985', 54_545, true, %w[one two])

      get :index, params: {}
      expect(response_body.first)
        .to include({ brand: 'Volkswagen' })
      expect(response_body.second)
        .to include({ brand: 'Ford' })
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a car record' do
      create_car('Volkswagen', '2009', 23_232, false, ['one'])
      car = Car.last

      delete :destroy, params: { id: car.id }
      expect(response).to have_http_status(:ok)
      expect(response.status_message).to eq('OK')
    end
  end

  private

  def create_car(brand, model, monetary_price, new_car, dealerships)
    params = {
      brand: brand,
      model: model,
      monetary_price: monetary_price,
      new: new_car,
      dealerships: dealerships
    }

    post :create, params: { car: params }
  end

  def response_body
    JSON.parse(response.body, symbolize_names: true)
  end
end
