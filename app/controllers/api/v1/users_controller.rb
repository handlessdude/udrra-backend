class Api::V1::UsersController < ApplicationController
  before_action :create_answer_template, only: [:create, :show]

  # POST /users
  def create
    parameters = user_params
    parameters[:password_confirmation] = parameters[:password]
    @user = User.create(parameters)
    role = Role.find_by(role_name: "user")
    @user.roles << role
    # role = Role.find_by(role_name: "admin")
    # @user.roles << role

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