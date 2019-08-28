class CategoriesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]
  # GET /s3/direct_post
  def index
    render json: Category.all
  end
end
