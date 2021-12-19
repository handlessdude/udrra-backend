class Api::V1::UsersController < ApplicationController

  # GET /users
  def show
    @users = User.all
    offset = params[:offset]
    limit = params[:limit]

    if offset.present?
      @users= @users.drop(offset.to_i)
    end

    if limit.present?
      @users = @users.first(limit.to_i)
    end

    render json: @users
  end

  # POST /users
  def create
    parameters = user_params
    pw = parameters[:password]
    en_pw = BCrypt::Password.create(pw)
    parameters[:encrypted_password] = parameters.delete :password
    parameters[:encrypted_password] = en_pw
    @user = User.create(parameters)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:login, :password, :first_name, :second_name, :faculty)
  end
end
