class CallroomsController < ApplicationController
  def index
    @callrooms = Callroom.where(status:1, student_id:nil).includes(:user).order("created_at DESC").page(params[:page]).per(12)
  end

  def new
    @callroom = Callroom.new
  end

  def create
    @callroom = Callroom.new(callroom_params)
    if @callroom.save && @callroom.status == 0
      redirect_to callroom_path(@callroom.id),alert: "非公開にしました"
    elsif @callroom.save && @callroom.status == 1
      redirect_to callroom_path(@callroom.id),notice: "公開にしました"
    else
      render :new
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
    @callroom = Callroom.find(params[:id])
    if @callroom.update(callroom_params) && @callroom.status == 0
      redirect_to callroom_path(@callroom.id),alert: "非公開にしました"
    elsif @callroom.update(callroom_params) && @callroom.status == 1
      redirect_to callroom_path(@callroom.id),notice: "公開にしました"
    else
      render :edit
    end
  end

  def destroy
    @callroom = Callroom.find(params[:id])
    @callroom.destroy
    redirect_to root_path
  end

  def update_attribute
    respond_to do |format|
      # show画面の公開・非公開・通信を切る
      format.html do
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
      # show画面の通信終了(video終了)ボタン
      format.json do
        @callroom = Callroom.find(params[:id])
        @student = User.find_by(id:@callroom.student_id)
        @current_user = User.find_by(id:current_user.id)
        if @callroom.user_id == current_user.id
          @callroom.status = 1
          @callroom.student_id = []
          @callroom.save
        end
      end
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
        # tweet.indexの教えてもらうボタンを押すと動く
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