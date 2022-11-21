class ReviewsController < ApplicationController
  before_action :set_campsite, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.campsite = @campsite
    @review.save
    # if @review.save
    #   redirect_to campsite_path(@campsite)
    # else
    #   render :new, status: :unprocessable_entity
    # end
    respond_to do |format|
      if @review.save
        format.html { redirect_to restaurant_path(@restaurant, anchor: "review-#{@review.id}") }
        format.json # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render 'restaurants/show' }
        format.json # Follow the classic Rails flow and look for a create.json view
      end
    end
  end

  private

  def set_campsite
    @campsite = campsite.find(params[:campsite_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end