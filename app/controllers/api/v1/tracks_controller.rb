class Api::V1::TracksController < ApplicationController
  before_action :create_answer_template

  # POST /tracks
  def create
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights
    @track = Track.new(track_params)
    if @track.save
      @answer[:success] = true
      @answer[:message] = "New track (id=#{@track.id}) is successfully created"
      render json: @answer, status: :created
    else
      @answer[:message] = "Could not save the track"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # PUT /tracks/:id
  def update
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights
    return unless set_track
    if @track.update(track_params)
      @answer[:success] = true
      @answer[:message] = "Track is successfully updated"
      render json: @answer, status: :ok
    else
      @answer[:message] = "Could not update the track"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/:id
  def destroy
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights
    return unless set_track
    if @track.destroy
      @answer[:success] = true
      @answer[:message] = "Track was successfully deleted"
      render json: @answer, status: :ok
    else
      @answer[:message] = "Could not delete the track"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # GET /tracks/:id
  def show
    return unless set_user
    return unless check_if_signed_in
    return unless set_track
    @answer[:success] = true
    @answer[:message] = "Track is successfully shown"
    @answer[:data] = @track
    render json: @answer, status: :ok
  end

  # GET /tracks
  def index
    return unless set_user
    return unless check_if_signed_in
    @tracks = Track.all
    offset = params[:offset]
    limit = params[:limit]
    @tracks= @tracks.drop(offset.to_i) if offset.present?
    @tracks = @tracks.first(limit.to_i) if limit.present?
    @answer[:success] = true
    @answer[:message] = "Tracks are successfully shown"
    @answer[:data] = @tracks
    render json: @answer, status: :ok
  end

  private
  def check_access_rights
    unless @user.roles.map { |x| x.role_name }.any? { |x| x == "admin" }
      @answer[:message] = "You do not have access to this function"
      render json: @answer, status: :forbidden
      return false
    end
    return true
  end

  def check_if_signed_in
    token = request.headers["HTTP_ACCESSTOKEN"]
    if token.nil?
      @answer[:message] = "Did not receive access token"
      render json: @answer, status: :bad_request
      return false
    end
    if @user.auth_token != token
      @answer[:message] = "Access token is wrong"
      render json: @answer, status: :unauthorized
      return false
    else
      if DateTime.now.utc - @user.auth_token_date > 86400
        @answer[:message] = "Access token has been expired"
        render json: @answer, status: :unauthorized
        return false
      end
      return true
    end
  end

  def set_track
    id = params[:id]
    @track = Track.find_by(id: id)
    if @track.nil?
      @answer[:message] = "Could not find the track"
      render json: @answer, status: :not_found
      return false
    end
    return true
  end

  def set_user
    user_id = user_params[:userID]
    if user_id.nil?
      @answer[:message] = "Did not receive the userID"
      render json: @answer, status: :bad_request
      return false
    end
    @user = User.find_by(id: user_id)
    if @user.nil?
      @answer[:message] = "Could not find the user with id=#{user_id}"
      render json: @answer, status: :not_found
      return false
    end
    return true
  end


  def track_params
    params.require(:data).permit(:track_name, :preview_text, :preview_picture, :published, :mode)
  end

  def user_params
    params.permit(:userID)
  end

  def create_answer_template
    @answer = { success: false, message: "" }
  end
end
