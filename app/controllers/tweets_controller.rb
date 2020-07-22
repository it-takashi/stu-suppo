class TweetsController < ApplicationController

  def top_page
    @tweets = Tweet.all.includes(:user).order("created_at DESC").limit(6)
    @callrooms = Callroom.where(status:1, student_id:nil).includes(:user).order("created_at DESC").limit(6)
  end

  def index
    @tweets = Tweet.all.includes(:user).order("created_at DESC").page(params[:page]).per(12)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet =Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @reply = Reply.new
    @replies = @tweet.replies.includes(:user)
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to root_path
  end
end


private
def tweet_params
  params.require(:tweet).permit(:title, :body, :image).merge(user_id: current_user.id)
end
