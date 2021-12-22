class Api::V1::TrackDetailsController < ApplicationController
  before_action :create_answer_template
  #before_action :set_track_detail, only: [:update, :destroy, :show]

  # POST /tracks/:track_id/details
  def create
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights
    @track = Track.find_by(id: params[:track_id])
    if @track.nil?
      @answer[:message] = "Could not find the track"
      render json: @answer, status: :not_found
      return false
    end
    parameters = track_detail_params
    if parameters[:detail_type] == "event"
      @entity = Event.new(name: parameters[:entity_name])
    elsif parameters[:detail_type] == "course"
      @entity = Course.new(name: parameters[:entity_name], duration: parameters[:entity_duration])
    else
      @answer[:message] = "Wrong detail type"
      render json: @answer, status: :unprocessable_entity
      return
    end
    parameters[:entity_id] = @entity.id
    @detail = Detail.new(parameters)
    @entity.details << @detail
    @track.details << @detail
    @detail = Detail.create(track_detail_params)
    @track_detail = DetailsTrack.create(detail_id: detail.id, track_id: params[entity_duration])

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
    params.require(:data).permit(:detail_type, :entity_name, :entity_duration)
  end

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

  def user_params
    params.permit(:userID)
  end

  def track_assigns_params_to_create
    params.require(:data).permit(:user_id, :status, :finished)
  end

  def track_assigns_params_to_destroy
    params.require(:data).permit(:user_id)
  end


  def create_answer_template
    @answer = { success: false, message: "" }
  end

  def slice_user(user)
    filtered_user = user.slice(:first_name, :second_name, :avatar_url, :faculty_id, :created_at)
    filtered_user[:roles] = user.roles.map { |x| x.role_name }
    filtered_user[:id] = user.id
    filtered_user
  end
end

