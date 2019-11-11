class EventsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :check_user, only: [:update, :destroy]

  # GET /events
  def index
    render json: Event.all
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    new_event = { 'user_id' => current_user.id }
    new_event = event_params.merge(new_event)
    @event = Event.new(new_event)

    if @event.save
      attending = Attending.new(
        user_id: current_user.id,
        event_id: @event.id
      )
      if attending.save
        render json: @event, status: :created, location: @event
      else
        render json: attending.errors, status: :unprocessable_entity
      end
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    s3 = Aws::S3::Client.new.delete_object(
      bucket: ENV['S3_BUCKET'],
      key: "#{current_user.id}/#{@event.image_link.split('1%2F')[1]}"
    )
    @event.destroy
    
    return true
    
    rescue => e
      Rails.logger.error "Error deleting #{image}. Failure with S3 call. Details: #{e}; #{e.backtrace}"
    return false    
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def check_user
    if @event.user != current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def event_params
    params.fetch(:event, {}).permit(
      :user_id,
      :category_id,
      :image_link,
      :description,
      :name,
      :start,
      :end,
      :lat,
      :long,
      :limit
    )
  end
end
