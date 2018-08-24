require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /forecasts" do
    it "will redirect to home page" do
      get forecasts_path
      expect(response).to redirect_to root_url
    end
  end
end
