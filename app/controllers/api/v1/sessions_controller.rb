class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token,
                     if: proc { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    warden.authenticate!(auth_options)
  end

  def destroy
    current_user.update_column(:authentication_token, nil)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  end
end
