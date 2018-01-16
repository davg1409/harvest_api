class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end

  private
    def render_404 exception = nil
      logger.info "Rendering 404: #{exception.message}" if exception

      render json: {
        error: "Record Not Found!"
      }, status: 404 and return
    end

    def require_account!
      @account = current_api_v1_user.try(:account)

      if @account.blank?
        render json: {
          success: false, 
          error: "User account not found!!!"
        }, status: 404 and return
      end
    end

    def render_success!
      render json: {
        success: true
      }, status: 200
    end

    def unprocessable_entity!
      render json: {
        success: false
      }, status: 422
    end
end
