class Api::V1::TrackAssignsController < ApplicationController

  # POST /tracks/:track_id/track_assigns
  def create
    @track_user = TracksUser.new(track_assigns_params_to_create)

    if @track_user.save
      render json: @track_user, status: :created
    else
      render json: @track_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/:track_id/track_assigns
  def destroy
    parameters = track_assigns_params_to_destroy
    @track_user = TracksUser.where(track_id: parameters[:track_id], user_id: parameters[:user_id])
    @track_user.destroy_all
  end

  # GET /tracks/:track_id/track_assigns
  def index
    @track_assigns = TracksUser.where(track_id: params[:track_id])
    render json: @track_assigns
  end

  private
  def track_assigns_params_to_create
    params.permit(:track_id, :user_id, :status, :finished)
  end

  def track_assigns_params_to_destroy
    params.permit(:track_id, :user_id)
  end

end


