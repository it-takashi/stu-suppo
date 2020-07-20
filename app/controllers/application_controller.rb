class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_callroom
  before_action :set_student

  def set_callroom
    if user_signed_in?
      @callroom = Callroom.find_by(user_id: current_user.id)
    end
  end

  def set_student
    if user_signed_in? && @callroom.present? && @callroom.student_id.present?
      @student = User.find_by(id: @callroom.student_id)
    end
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:image, :introduction, :subject])
  end
end
