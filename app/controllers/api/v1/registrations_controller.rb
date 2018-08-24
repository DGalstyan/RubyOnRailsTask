class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token,
                     if: proc { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      sign_in resource
      render status: :created
    else
      render partial: "create_error.json", status: :unprocessable_entity
    end
  end
end
