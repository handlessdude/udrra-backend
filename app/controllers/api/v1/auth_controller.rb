class Api::V1::AuthController < ApplicationController
  before_action :create_answer_template, only: [:create]

  # POST /auth
  def create
    parameters = auth_params
    @user = User.find_by(login: parameters[:login])
    if @user.nil?
      @answer[:message] = "Could not find user with login = #{parameters[:login]}"
      render json: @answer, status: :not_found
      return
    end

    unless @user.authenticate(parameters[:password])
      @answer[:message] = "Wrong password"
      render json: @answer, status: :forbidden
      return
    end

    @user.regenerate_auth_token
    timestamp = DateTime.now.utc
    @user.auth_token_date = timestamp
    if @user.save
      @answer[:success] = true
      @answer[:message] = "Signed in successfully"
      expiration_time = (timestamp + 1.day).strftime("%d/%m/%Y %H:%M")
      @answer[:data] = { accessToken: @user.auth_token, expiration_time: expiration_time, user_info: slice_user(@user) }
      render json: @answer, status: :ok
    else
      @answer[:message] = "Could not save user changes"
      render json: @answer, status: :unprocessable_entity
    end
  end

  private
  def auth_params
    params.permit(:login, :password)
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
