class RatingsController < ApplicationController
  before_action :logged_in_user, :normal_user?, :check_rated, only: [:create]

  def create
    @rate = Rating.new rate_params
    if @rate.save
      flash[:success] = t "rates.success"
      redirect_to :back
    else
      flash[:danger] = t "rates.error"
      redirect_to root_path
    end
  end

  private
  def rate_params
    params.require(:rate).permit :vote, :product_id, :user_id
  end

  def check_rated
    @product = Product.find_by id: params[:rate][:product_id]
    if current_user.has_voting @product
      flash[:danger] = t "rates.fail"
      redirect_to @product
    end
  end
end
