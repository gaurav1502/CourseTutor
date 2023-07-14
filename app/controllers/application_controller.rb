class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  private

  def handle_parameter_missing(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
