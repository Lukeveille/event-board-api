class AttendingsController < ApplicationController
  before_action :set_attending, only: [:destroy]
  
  def attending_list(list, param)
    array = []
    list.each do |hash|
      array.push(hash[param])
    end
    render json: array
  end

  def index
    attending_list(User.find(current_user.id).attendings, 'event_id')
  end

  def show
    attending_list(Event.find(params[:id]).attendings, 'user_id')
  end

  # POST /attendings
  def create
    puts attending_params
    attend = { 'user_id' => current_user.id }
    attend = attending_params.merge(attend)
    @attending = Attending.new(attend)
    
    if @attending.save
      render json: @attending, status: :created
    else
      render json: @attending.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attendings/1
  def destroy
    if @attending
      @attending.destroy
    else
      render json: { error: 'Not Found', status: 404 }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attending
      @attending = Attending.find_by(user_id: current_user.id, event_id: attending_params[:event_id])
    end

    # Only allow a trusted parameter "white list" through.
    def attending_params
      params.fetch(:attending, {}).permit(
        :user_id,
        :event_id
      )
    end
end
