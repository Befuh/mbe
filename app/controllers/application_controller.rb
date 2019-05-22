class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  private

  def render_record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
