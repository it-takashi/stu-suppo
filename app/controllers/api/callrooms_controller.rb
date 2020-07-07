class Api::CallroomsController < ApplicationController
  def index
    # ルーティングでの設定によりparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する
    if user_signed_in?
      @callroom = Callroom.find_by(user_id: current_user.id)
      # binding.pry
      if @callroom.present? && @callroom.status == 2
        @student = User.find_by(id: @callroom.student_id)
      end
    end
  end
end