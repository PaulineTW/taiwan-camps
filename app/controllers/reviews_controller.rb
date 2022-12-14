class ReviewsController < ApplicationController
  before_action :find_campsite, only: %i[new create]
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.campsite_id = @campsite.id
    @review.save
    if @review.save
      redirect_to campsite_path(@campsite, anchor: "review-#{@review.id}")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
		if @review.update(review_params)
			redirect_to campsite_path(@campsite)
		else
			render :edit
		end
	end

	def destroy
		@review.destroy
		redirect_to campsite_path(@campsite)
	end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def find_campsite
    @campsite = Campsite.find(params[:campsite_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
