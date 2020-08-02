class ReviewsController < ApplicationController
  before_action :set_callroom3
  
  def create
    review = @callroom.reviews.new(review_params)
    # binding.pry
    if review.save
      redirect_to root_path
    else
      review = @callroom.reviews.includes(:user)
      flash.now[:alert] = 'レートを入力してください。'
      # render text: "mojiretsu"
      redirect_to root_path
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