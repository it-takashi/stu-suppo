class UsersController < ApplicationController

  before_action :check_guest, only:[:edit]

  def edit
  end
  
  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # def update_attribute
  #   if current_user.called == false
  #     current_user.called = 1
  #     current_user.save
  #   else current_user.called == 1
  #     current_user.called = 0
  #     current_user.save
  #   end
  #   redirect_to root_path
  # end

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: params[:id]).includes(:user).order("created_at DESC").limit(6)
    @user_callroom = Callroom.find_by(user_id: params[:id])
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :image, :introduction, :subject, :email)
  end


  def check_guest
    email = current_user&.email || params[:user][:email].downcase
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは編集できません。'
    end
  end

end