class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private
    def render_404 exception = nil
      logger.info "Rendering 404: #{exception.message}" if exception

      render json: {
        error: "Record Not Found!"
      }, status: 404 and return
    end
end
