class ReviewsController < ApplicationController

  # POST /products/:product_id/reviews
  def new
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else
      redirect_to product_path(@product)

      flash.alert = 'Could not post review.'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to "/products/#{params[:product_id]}", notice: 'Product deleted!'
  end


  private

    def review_params
      params.require(:review).permit(:product_id, :description, :rating)
    end
end
