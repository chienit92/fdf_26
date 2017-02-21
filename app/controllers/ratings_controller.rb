class RatingsController < ApplicationController
  before_action :logged_in_user, :check_rating, only: [:create]

  def create
    @rating = Rating.new rating_params
    if @rating.save
      flash[:success] = t "rates.success"
      redirect_to :back
    else
      flash[:danger] = t "rates.error"
      redirect_to root_path
    end
  end

  private
  def rating_params
    params.require(:rating).permit :vote, :product_id, :user_id
  end

  def check_rating
    @product = Product.find_by_id params[:rating][:product_id]
    if current_user.has_voting @product
      flash[:danger] = t "rates.fail"
      redirect_to @product
    end
  end
end
