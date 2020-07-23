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

  # 自動更新　生徒側で着信があるか
  def new
    if user_signed_in?
      @callroom = Callroom.find_by(student_id: current_user.id)
    end
  end
end