class ReviewsController < ApplicationController
  def create
    @review = Review.new(params_review)
    @review.update(user_id: current_user.id) if current_user.id.present?
    redirect_to request.referer
  end

  private

  def params_review
    params.require(:review).permit(:book_id, :comment)
  end
end
