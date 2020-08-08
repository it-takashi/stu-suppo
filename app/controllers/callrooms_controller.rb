class CallroomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

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
      @message = Message.new
      @messages = @callroom.messages.includes(:user)
      @review = Review.new
      gon.skyway_key = ENV['SKYWAY_KEY']
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
        @callroom.user_id == current_user.id
        @callroom.status = 1
        @callroom.student_id = []
        @callroom.save
      end
    end
  end

  def call
    respond_to do |format|
      # 先生側　着信モーダル後の承認するボタンを押すとstatusが3になる。
      format.html do
        if @callroom.status == 2 && @callroom.student_id.present? && @callroom.user_id == current_user.id
          @callroom.status = 3
          @callroom.save
          redirect_to callroom_path(@callroom.id)
        end
      end
      format.json do
        # 生徒側 電話するをクリックすると動く すでに誰かに連絡中の場合新たに連絡することはできない。
        @callroom = Callroom.find(params[:id])
        @already_callroom = Callroom.find_by(student_id: current_user.id)
        if @callroom.status == 1 && @already_callroom.nil? && @callroom.student_id.nil?
          @callroom.student_id = current_user.id
          @callroom.status = 2
          @callroom.save
          @student = current_user
          NotificationMailer.send_called_to_user(@user, @student).deliver
        else @callroom.status == 2 && @callroom.student_id == current_user.id
          @student = current_user
        end
      end
    end
  end


  # 生徒側から連絡のキャンセル
  def cancelcall
    @callroom = Callroom.find(params[:id])
    if @callroom.status == 2 && @callroom.student_id == current_user.id
      @callroom.status = 1
      @callroom.student_id = []
      @callroom.save
    end
  end
  
end

private
def callroom_params
  params.require(:callroom).permit(:title, :body, :image,:status).merge(user_id: current_user.id)
end