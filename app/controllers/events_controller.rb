class EventsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :check_user, only: [:update, :destroy]

  # GET /events
  def index
    render json: Event.all.order(:start).where('DATE(start) > ?', Date.today)
    # render json: Event.all.order(:start)
  end

  # GET /events/1
  def show
    render json: @event
  end

  def user
    render json: Event.where(:user_id => current_user.id)
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
      key: "#{current_user.id}/#{set_filename}"
    )
    @event.destroy
    
    return true
    
    rescue => e
      Rails.logger.error "Error deleting #{image}. Failure with S3 call. Details: #{e}; #{e.backtrace}"
    return false    
  end

  private

  def set_filename
    filename = @event.image_link.split('1%2F')[1]
    [
      ['+', ' '],
      ['%20', ' '],
      ['%21', '!'],
      ['%22', '"'],
      ['%23', '#'],
      ['%24', '$'],
      ['%25', '%'],
      ['%26', '&'],
      ['%27', '\''],
      ['%28', '('],
      ['%29', ')'],
      ['%2A', '*'],
      ['%2B', '+'],
      ['%2C', ','],
      ['%2D', '-'],
      ['%2E', '.'],
      ['%2F', '/']
    ].each do |symbol|
      if filename.include? symbol[0]
        filename.gsub! symbol[0], symbol[1]
      end
    end

    return filename
  end

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
