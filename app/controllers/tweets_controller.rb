class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.includes(:user)
    @teaches = Teach.all.includes(:user)
    @callrooms = Callroom.where(release:1)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
    redirect_to root_path
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
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to root_path
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
