class Api::V1::TracksController < ApplicationController
  before_action :set_track, only: [:show, :update, :destroy]

  # POST /tracks
  def create
    @track = Track.new(track_params)

    if @track.save
      render json: @track, status: :created, location: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # PUT /tracks/:id
  def update
    if @track.update(track_params)
      render json: @track
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/:id
  def destroy
    @track.destroy
  end

  # GET /tracks/:id
  def show
    render json: @track
  end

  # GET /tracks
  def index
    @tracks = Track.all
    offset = params[:offset]
    limit = params[:limit]

    if offset.present?
      @tracks= @tracks.drop(offset.to_i)
    end

    if limit.present?
      @tracks = @tracks.first(limit.to_i)
    end

    render json: @tracks
  end

  private
    def set_track
      id = params[:id]
      if id.nil?
        id = params[:track_id]
      end
      @track = Track.find(id)
    end

    def track_params
      params.permit(:track_name, :preview_text, :preview_picture, :published, :mode)
    end
end
