require 'rails_helper'

RSpec.describe Api::V1::ForecastsController, type: :controller do
  before do
    request.accept = "application/json"
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to be_success
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end
end
