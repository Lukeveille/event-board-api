class CategoriesController < ApplicationController
  # GET /s3/direct_post
  def index
    render json: Category.all
  end
end
