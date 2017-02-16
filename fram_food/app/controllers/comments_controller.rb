class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_product

  def create
    @comment = @product.comments.build comments_params
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to product_path @product
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def comments_params
    params.require(:comment).permit :content, :product_id, :user_id
  end

  def find_product
    @product = Product.find_by id: params[:product_id]
    unless @product
      flash.now[:danger] = t "controller.comments.not_exist"
      redirect_to product_path
    end
  end
end
