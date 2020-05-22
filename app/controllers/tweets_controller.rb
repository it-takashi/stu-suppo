class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.includes(:user)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    redirect_to root_path
  end

  def show
    @tweet = Tweet.find(params[:id])
  end
end

private
def tweet_params
  params.require(:tweet).permit(:title, :body, :image).merge(user_id: current_user.id)
end
