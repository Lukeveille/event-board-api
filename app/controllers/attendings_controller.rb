class AttendingsController < ApplicationController
  before_action :set_attending, only: [:destroy]

  # POST /attendings
  def create
    puts "made it this far"
    @attending = Attending.new(attending_params)

    if @attending.save
      render json: @attending, status: :created, location: @attending
    else
      render json: @attending.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attendings/1
  def destroy
    @attending.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attending
      @attending = Attending.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attending_params
      params.fetch(:attending, {}).permit(
        :user_id,
        :event_id
      )
    end
end
