require 'rails_helper'

RSpec.describe ForecastsController do
  let(:user) { create :user }
  let(:json) { JSON.parse(response.body) }
  let(:valid_attributes) do
    {
      name: 'Brno',
      country_code: 'CZ',
      city_id: 1,
      data: File.read(Rails.root.join('spec', 'test_files_for_usage', 'weather_api_sample_data.json')),
      lat: '49.1952',
      lng: '16.608',
      time_zone_name: 'Europe/Prague',
      time_zone_offset: '3600'
    }
  end

  render_views

  before do
    sign_in user
    @forecast = user.forecasts.create(valid_attributes)
  end

  describe "GET #index" do
    it "assigns all" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "renders as html" do
      get :show, id: @forecast.id
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "assigns a new forecast as @forecast" do
      get :new
      expect(response).to be_success
    end
  end
end
