class RepliesController < ApplicationController
  before_action :set_tweet
  def create
    @reply = @tweet.replies.new(reply_params)
    if @reply.save
      respond_to do |format|
        format.json
      end
    else
      @replies = @tweet.replies.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render template: 'tweet/show', layout: 'show'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end