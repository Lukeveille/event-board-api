class AttendingsController < ApplicationController
  before_action :set_attending, only: [:destroy]

  # POST /attendings
  def create
    # puts attending_params['event_id']
    event = Event.find(attending_params['event_id'])
    
    puts "params"
    puts event.users.length
    puts event.limit

    if event.users.length < event.limit
      attend = { 'user_id' => current_user.id }
      attend = attending_params.merge(attend)
      @attending = Attending.new(attend)
      if @attending.save
        render json: @attending, status: :created
      else
        render json: @attending, status: :unprocessable_entity
      end
    else
      render json: {error: 'Event at limit'}, status: :unprocessable_entity
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
