class Api::V1::TrackDetailsController < ApplicationController
  before_action :set_track_detail, only: [:update, :destroy, :show]

  # POST /tracks/:track_id/details
  def create
    @detail = Detail.create(track_detail_params)
    @track_detail = DetailsTrack.create(detail_id: detail.id, track_id: params[track_id])

    unless @track_detail.save
      render json: @track_detail.errors, status: :unprocessable_entity
      return
    end

    if @detail.save
      render json: @detail, status: :created, location: @detail
    else
      render json: @detail.errors, status: :unprocessable_entity
    end
  end

  # PUT /tracks/details/:track_detail_id
  def update
    if @detail.update(track_detail_params)
      render json: @detail
    else
      render json: @detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/details/:track_detail_id
  def destroy
    @detail.destroy
  end

  # GET /tracks/details/:track_detail_id
  def show
    render json: @detail
  end

  # GET /tracks/:track_id/details
  def index
    @details = Track.find(params[:track_id]).details
    offset = params[:offset]
    limit = params[:limit]

    if offset.present?
      @details = @details.drop(offset.to_i)
    end

    if limit.present?
      @details = @details.first(limit.to_i)
    end

    render json: @details
  end

  private
  def set_track_detail
    @detail = Detail.find(params[:track_detail_id])
  end

  def track_detail_params
    params.permit(:detail_type, :entity_name, :entity_duration, :entity_type, :entity_id)
  end
end

