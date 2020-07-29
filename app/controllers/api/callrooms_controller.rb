class Api::CallroomsController < ApplicationController
  # 自動更新　先生側着信があるか
  def index
    if user_signed_in?
      @callroom = Callroom.find_by(user_id: current_user.id)
      if @callroom.present? && @callroom.status == 2
        @student = User.find_by(id: @callroom.student_id)
      end
    end
  end

  # 自動更新 生徒側で着信があるか
  # @callrooms10の役割
  ## 今のstatusの状況を見る
  ### 3のときは、ajaxでモーダル表示
  ### 2のときは、一度section[:callroom]で渡すことstatusが1になったとき（断られてたとき）のモーダルをajaxで表示できる。（@callroom_now）
  def new
    if user_signed_in?
      if session[:callroom].present?
        @callroom_now = Callroom.find_by(id: session[:callroom]["id"])
      end
      @callroom10 = Callroom.find_by(student_id: current_user.id, status: 2,status: 3)
      session[:callroom] = @callroom10
    end
  end
end