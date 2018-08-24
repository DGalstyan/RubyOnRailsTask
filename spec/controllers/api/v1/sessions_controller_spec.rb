require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  let(:user) { create :user, password: "P@ssw0rd!" }
  let(:json) { JSON.parse(response.body) }

  render_views

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    request.accept = "application/json"
  end

  before do
    request.accept = "application/json"
  end

  it "#create" do
    post :create, user: {email: user.email, password: "P@ssw0rd!"}
    expect(response).to be_success
    expect(json["email"]).to eq user.email
    expect(controller.current_user).to eq user
  end

  it "#destroy" do
    sign_in user
    delete :destroy
    expect(response).to be_success
    expect(controller.current_user).to eq nil
    expect(json['message']).to eq 'Signed out successfully.'
  end
end
