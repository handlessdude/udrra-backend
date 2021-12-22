class Api::V1::TrackAssignsController < ApplicationController
  before_action :create_answer_template

  # POST /tracks/:track_id/track_assigns
  def create
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights
    parameters = track_assigns_params_to_create
    parameters[:track_id] = params[:track_id]
    @track_user = TracksUser.new(parameters)
    if @track_user.save
      @answer[:success] = true
      @answer[:message] = "Track is successfully assigned to user"
      render json: @answer, status: :created
    else
      @answer[:message] = "Could not assign track to user"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # DELETE /tracks/:track_id/track_assigns
  def destroy
    return unless set_user
    return unless check_if_signed_in
    return unless check_access_rights
    parameters = track_assigns_params_to_destroy
    parameters[:track_id] = params[:track_id]
    @track_user = TracksUser.find_by(track_id: parameters[:track_id], user_id: parameters[:user_id])
    if @track_user.nil?
      @answer[:message] = "Track is not assigned to user"
      render json: @track_user.errors, status: :not_found
      return
    end
    if @track_user.destroy
      @answer[:success] = true
      @answer[:message] = "Track assignment was deleted successfully"
      render json: @answer, status: :ok
    else
      @answer[:message] = "Could not delete track assignment"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # GET /tracks/:track_id/track_assigns
  def index
    return unless set_user
    return unless check_if_signed_in
    user_ids = TracksUser.where(track_id: params[:track_id]).map { |x| x.user_id }
    puts user_ids.class
    users = User.all.filter { |x| user_ids.include?(x.id)}.map { |x| slice_user(x) }
    @answer[:success] = true
    @answer[:message] = "Track assignments are successfully shown"
    @answer[:data] = users
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
    filtered_user = user.slice(:login, :first_name, :second_name, :avatar_url, :faculty_id, :created_at)
    filtered_user[:roles] = user.roles.map { |x| x.role_name }
    filtered_user[:id] = user.id
    filtered_user
  end

end


