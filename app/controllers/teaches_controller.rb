class TeachesController < ApplicationController

  def index
    @teaches = Teach.all.includes(:user)
  end

  def new
@teach = Teach.new
  end

  def create
    @teach =  Teach.create(teach_params)
    redirect_to root_path
  end

  def show
    @teach = Teach.find(params[:id])
  end


  def edit
    @teach = Teach.find(params[:id])
  end

  def update
    @tweet = Teach.find(params[:id])
    @tweet.update(teach_params)
    redirect_to root_path
  end

end

private
def teach_params
  params.require(:teach).permit(:title, :body, :image).merge(user_id: current_user.id)
end