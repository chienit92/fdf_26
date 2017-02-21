class Admins::CategoriesController < ApplicationController
  layout "admin_layout"
  before_action :logged_in_user, :verify_admin
  before_action :load_category, only: [:update, :destroy]

  def index
    @category = Category.new
    @categories = Category.paginate page: params[:page], per_page: Settings.five
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admins_categories_path
      flash.now[:success] = t ".add_success"
    else
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash.now[:success] = t ".update_success"
      redirect_to admins_categories_path
    else
      flash.now[:danger] = t ".update_fail"
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html {redirect_to admins_categories_path}
      format.json {head :no_content}
      format.js {render layout: false}
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t ".not_found"
      redirect_to admins_categories_path
    end
  end
end
