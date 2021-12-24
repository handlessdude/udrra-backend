class Api::V1::UsersController < ApplicationController
  before_action :create_answer_template, only: [:create, :show]

  # POST /users
  def create
    parameters = user_params
    parameters[:password_confirmation] = parameters[:password]
    @user = User.create(parameters)
    role = Role.find_by(role_name: "user")
    @user.roles << role
    # uncomment to become admin!
    role = Role.find_by(role_name: "admin")
    @user.roles << role

    if @user.save
      @answer[:success] = true
      @answer[:message] = "New user (id=#{@user.id}) is successfully created"
      render json: @answer, status: :created
    else
      @answer[:message] = "Could not save new user"
      render json: @answer, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    return unless set_user
    return unless check_if_signed_in
    user = User.find_by(id: params[:id])
    if user.nil?
      @answer[:message] = "Not found user with id=#{params[:id]}"
      render json: @answer, status: :not_found
      return
    end
    @answer[:success] = true
    @answer[:message] = "User has been successfully found"
    @answer[:data] = slice_user(user)
    render json: @answer, status: :ok
  end

  private
  def user_params
    params.permit(:login, :email, :first_name, :second_name, :password)
  end

  def slice_user(user)
    filtered_user = user.slice(:login, :first_name, :second_name, :avatar_url, :faculty_id, :created_at)
    filtered_user[:roles] = user.roles.map { |x| x.role_name }
    filtered_user[:id] = user.id
    filtered_user
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
    user_id = params[:userID]
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

  def create_answer_template
    @answer = { success: false, message: "" }
  end
end