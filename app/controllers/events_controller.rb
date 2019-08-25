class EventsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :check_user, only: [:update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
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
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
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
        :name,
        :start,
        :end,
        :lat,
        :long,
        :limit
      )
    end
end
