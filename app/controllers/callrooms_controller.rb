class CallroomsController < ApplicationController
  def new
    @callroom = Callroom.new
  end

  def create
    callroom =  Callroom.create(callroom_params)
    if callroom.status == 0
      redirect_to callroom_path(callroom.id),alert: "非公開にしました"
    else
      redirect_to callroom_path(callroom.id),notice: "公開にしました"
    end
  end

  def show
    @callroom = Callroom.find(params[:id])
    # 公開がで生徒がいるときは、先生と生徒しか入ることができない
    if @callroom.user_id == current_user.id or @callroom.status == 3 && @callroom.student_id == current_user.id
      @student = User.find_by(id:@callroom.student_id)
    else
      redirect_to root_path
    end
  end

  def edit
    # 教えるモードでは、editページへ
    @callroom = Callroom.find(params[:id])
  end

  def update
    callroom = Callroom.find(params[:id])
    callroom.update(callroom_params)
    if callroom.status == false
      redirect_to callroom_path(callroom.id),alert: "非公開にしました"
    else
      redirect_to callroom_path(callroom.id),notice: "公開にしました"
    end
  end

  def destroy
    @callroom = Callroom.find(params[:id])
    @callroom.destroy
    redirect_to root_path
  end

  def update_attribute
    callroom = Callroom.find_by(user_id:current_user.id)
    if callroom.status == 1
      callroom.status = 0
      callroom.student_id = []
      callroom.save
      redirect_to callroom_path(callroom.id), alert: "非公開にしました"
    elsif callroom.status == 0
      callroom.status = 1
      callroom.save
      redirect_to callroom_path(callroom.id), notice: "公開にしました"
    elsif callroom.status == 2 
      callroom.status = 1
      callroom.student_id = []
      callroom.save
      redirect_to callroom_path(callroom.id), notice: "連絡をキャセルしました。"
    else callroom.status == 3
      student = User.find_by(id:callroom.student_id)
      callroom.status = 1
      callroom.student_id = []
      callroom.save
      redirect_to callroom_path(callroom.id), notice: "#{student.name}さんとの通信を終了しました。ただいま公開中です"
    end
  end

  def call
    respond_to do |format|
      format.html do
        # @callroom = Callroom.find(params[:id])
        if @callroom.status == 2 && @callroom.student_id.present? && @callroom.user_id == current_user.id
          @callroom.status = 3
          @callroom.save
          redirect_to callroom_path(@callroom.id)
        end
      end
      format.json do
        # binding.pry
        # 教えてもらうボタンを押すと動く
        @callroom = Callroom.find(params[:id])
        if @callroom.status == 1 && @callroom.student_id.nil?
          @callroom.student_id = current_user.id
          @callroom.status = 2
          @callroom.save
          @student = current_user
        else @callroom.status == 2 && @callroom.student_id == current_user.id
          @student = current_user
        end
      end
    end
  end

end

private
def callroom_params
  params.require(:callroom).permit(:title, :body, :image,:status).merge(user_id: current_user.id)
end