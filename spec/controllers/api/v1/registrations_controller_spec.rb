require 'rails_helper'

describe Api::V1::RegistrationsController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  render_views

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    request.accept = "application/json"
  end

  it "#create" do
    post :create, user: {email: "aaa@test.com", password: "P@ssw0rd!"}
    puts response.inspect
    expect(response).to be_success
    expect(json["email"]).to eq 'aaa@test.com'
  end
end
