class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_event, except: [:index, :new, :create]
  before_action :password_guard!, only: [:show]
  after_action :verify_authorized, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build
    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)

    authorize @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: I18n.t('controllers.events.created') }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @event

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: I18n.t('controllers.events.updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @event

    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: I18n.t('controllers.events.deleted') }
    end
  end

  private

  def password_guard!
    return  true if @event.pincode.blank?
    return  true if signed_in? && current_user == @event.user

    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    unless @event.pincode_valid?(cookies.permanent["events_#{@event.id}_pincode"])
      flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?

      render 'password_form'
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :description, :datetime, :pincode)
  end
end
