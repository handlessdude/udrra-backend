class Api::V1::TestsController < ApplicationController
  before_action :create_answer_template

  # POST /tests
  def create
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights

    det_params = detail_params
    detail_type = det_params[:detail_type]
    if detail_type == "event"
      ps = event_params
      @entity = Event.new(name: ps[:entity_name], duration: ps[:entity_duration])
    elsif detail_type == "course"
      ps = course_params
      @entity = Course.new(name: ps[:entity_name], duration: ps[:entity_duration])
    elsif detail_type == "file"
      ps = file_params
      @entity = PostedFile.new(file_type: ps[:file_type], url: ps[:url])
    else
      @answer[:message] = "Wrong detail type"
      render json: @answer, status: :unprocessable_entity
      return
    end

    unless @entity.save
      @answer[:message] = "Could not save new entity"
      render json: @answer, status: :unprocessable_entity
      return
    end

    @detail = Detail.new(detail_type: detail_type, entity_name: ps[:entity_name], entity: @entity)
    unless @detail.save
      @answer[:message] = "Could not save new detail based on existing entity"
      render json: @answer, status: :unprocessable_entity
      return
    end

    @detail_track = DetailsTrack.new(track_id: params[:track_id], detail_id: @detail.id, finished: det_params[:finished], assigned: det_params[:assigned])
    if @detail_track.save
      @answer[:success] = true
      @answer[:message] = "New track detail (id=#{@detail.id}) is successfully created"
      render json: @answer, status: :created
    else
      @answer[:message] = "Could not save new track detail"
      render json: @answer, status: :unprocessable_entity
      return
    end
  end

  # PUT /tracks/details/:track_detail_id
  def update
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights

    @detail = Detail.find_by(id: params[:track_detail_id])
    if @detail.nil?
      @answer[:message] = "Could not find track detail"
      render json: @answer, status: :not_found
      return
    end

    det_params = detail_params
    detail_type = det_params[:detail_type]
    if detail_type == "event"
      ps = event_params
      @detail.entity.update(name: ps[:entity_name], duration: ps[:entity_duration])
    elsif detail_type == "course"
      ps = course_params
      @detail.entity.update(name: ps[:entity_name], duration: ps[:entity_duration])
    elsif detail_type == "file"
      ps = file_params
      @detail.entity.update(file_type: ps[:file_type], url: ps[:url])
    else
      @answer[:message] = "Wrong detail type"
      render json: @answer, status: :unprocessable_entity
      return
    end
    @detail.update(entity_name: ps[:entity_name])

    unless @detail.save
      @answer[:message] = "Could not save updated detail"
      render json: @answer, status: :unprocessable_entity
      return
    end

    track_id = params.require(:data).permit(:track_id)[:track_id]
    @detail_track = DetailsTrack.find_by(track_id: track_id, detail_id: params[:track_detail_id])
    if @detail_track.nil?
      @answer[:message] = "Could not find connection for these detail and track"
      render json: @answer, status: :unprocessable_entity
      return
    end
    @detail_track.update(finished: det_params[:finished], assigned: det_params[:assigned])
    if @detail_track.save
      @answer[:success] = true
      @answer[:message] = "Track detail is successfully updated"
      render json: @answer, status: :ok
    else
      @answer[:message] = "Could not save updated track detail"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/details/:track_detail_id
  def destroy
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights

    @detail = Detail.find_by(id: params[:track_detail_id])
    if @detail.nil?
      @answer[:message] = "Could not find track detail"
      render json: @answer, status: :not_found
      return
    end

    track_id = params.require(:data).permit(:track_id)[:track_id]
    @detail_track = DetailsTrack.find_by(track_id: track_id, detail_id: params[:track_detail_id])
    if @detail_track.nil?
      @answer[:message] = "Could not find connection for these detail and track"
      render json: @answer, status: :unprocessable_entity
      return
    end

    if @detail_track.destroy
      @answer[:success] = true
      @answer[:message] = "Track detail was successfully deleted"
      render json: @answer, status: :ok
    else
      @answer[:message] = "Could not delete track detail"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # GET /tracks/details/:track_detail_id
  def show
    return unless set_user
    return unless check_if_signed_in
    @detail = Detail.find_by(id: params[:track_detail_id])
    if @detail.nil?
      @answer[:message] = "Could not find track detail"
      render json: @answer, status: :not_found
      return
    end
    @entity = @detail.entity
    @answer[:success] = true
    @answer[:message] = "Track detail is successfully shown"
    h = { detail_type: @detail.detail_type, entity_name: @detail.entity_name, entity: @entity }
    @answer[:data] = h
    render json: @answer, status: :ok
  end

  # GET /tracks/:track_id/details
  def index
    return unless set_user
    return unless check_if_signed_in
    detail_ids = DetailsTrack.where(track_id: params[:track_id]).map { |x| x.detail_id }
    if detail_ids.nil?
      @answer[:message] = "No details for this track"
      render json: @answer, status: :not_found
      return
    end
    @details = Detail.all.filter { |x| detail_ids.include?(x.id) }
    offset = params[:offset]
    limit = params[:limit]
    @details = @details.drop(offset.to_i) if offset.present?
    @details = @details.first(limit.to_i) if limit.present?
    @answer[:success] = true
    @answer[:message] = "Track details are successfully shown"
    @answer[:data] = @details
    render json: @answer, status: :ok
  end

  private
  def test_params
    params.require(:data).permit(:name, :description, :instruction, :duration, :img)
  end

  def file_params
    params.require(:data).permit(:entity_name, :file_type, :url)
  end

  def course_params
    params.require(:data).permit(:entity_name, :entity_duration)
  end

  def event_params
    params.require(:data).permit(:entity_name, :entity_duration)
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


