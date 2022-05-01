class ApplicationController < ActionController::Base
  # Ensure that CanCanCan is correctly configured
  # and authorising actions on each controller
  # check_authorization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :update_headers_to_disable_caching
  before_action :ie_warning

  before_action :configure_permitted_parameters, if: :devise_controller?

  #class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_user.tag.name == 'Walker'
      session[:current_user_id] = current_user.id
      session[:opted_in] = OptedInLeaderboard.where(user_id: session[:current_user_id]).first.opted_in
      pick_event_pages_path
    elsif current_user.tag.name == 'Marshal'
      session[:current_user_id] = current_user.id
      @marshal = Marshall.where(users_id: session[:current_user_id]).first
      choose_event_marshals_path
    elsif current_user.tag.name == 'Admin'
      session[:current_user_id] = current_user.id
      admins_path
    end
  end

  # Catch NotFound exceptions and handle them neatly, when URLs are mistyped or mislinked
  rescue_from ActiveRecord::RecordNotFound do
    render template: 'errors/error_404', status: 404
  end
  rescue_from CanCan::AccessDenied do
    render template: 'errors/error_403', status: 403
  end

  # IE over HTTPS will not download if browser caching is off, so allow browser caching when sending files
  def send_file(file, opts={})
    response.headers['Cache-Control'] = 'private, proxy-revalidate' # Still prevent proxy caching
    response.headers['Pragma'] = 'cache'
    response.headers['Expires'] = '0'
    super(file, opts)
  end

  private
    def update_headers_to_disable_caching
      response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
      response.headers['Pragma'] = 'no-cache'
      response.headers['Expires'] = '-1'
    end

    def ie_warning
      return redirect_to(ie_warning_path) if request.user_agent.to_s =~ /MSIE [6-7]/ && request.user_agent.to_s !~ /Trident\/7.0/
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile, :avatar])
    end
end
