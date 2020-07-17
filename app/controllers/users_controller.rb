class UsersController < ApplicationController

  def edit
  end
  
  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def update_attribute
    if current_user.called == false
      current_user.called = 1
      current_user.save
    else current_user.called == 1
      current_user.called = 0
      current_user.save
    end
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
  end
  
end
private
def user_params
  params.require(:user).permit(:name, :image, :introduction, :profile, :subject, :email)
end