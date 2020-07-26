class ReviewsController < ApplicationController
  before_action :set_callroom3
  def create
    review = @callroom.reviews.new(review_params)
    if review.save
      redirect_to root_path
    else
      review = @callroom.reviews.includes(:user)
      flash.now[:alert] = 'レートを入力してください。'
      # render template: 'callroom/show', layout: 'html'
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rate).merge(user_id: current_user.id)
  end

  def set_callroom3
    @callroom = Callroom.find(params[:callroom_id])
  end
end