class TweetsController < ApplicationController
  def index
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    redirect_to root_path
  end

end

private
def tweet_params
  params.require(:tweet).premit(:title, :body, :image).merge(user_id: current_user.id)
end
