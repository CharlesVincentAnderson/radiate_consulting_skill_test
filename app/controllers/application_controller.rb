class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  protected

  def user_not_authorized(exception)
    # if they requested html, set flash alert and redirect them
    # if they requested json, give them access denied json message
    # default pundit message can be overidden by message starting with "warning"
    # raise NotAuthorizedError, "Warning: enter message here" if condition
    msg = exception.message['Warning'] ? exception.message : 'Access denied.'
    respond_to do |format|
      format.html do
        referrer = request.referrer
        # if not present or matches request url, go to root path
        path = referrer.nil? || referrer == request.url ? root_path : referrer
        redirect_to path, alert: msg
      end
      format.pdf do
        referrer = request.referrer
        # if not present or matches request url, go to root path
        path = referrer.nil? || referrer == request.url ? root_path : referrer
        redirect_to path, alert: msg
      end
      format.json { render json: { message: msg } }
    end
  end
end
