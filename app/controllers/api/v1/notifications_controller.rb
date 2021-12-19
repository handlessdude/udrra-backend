class Api::V1::NotificationsController < ApplicationController
  before_action :set_user

  # GET /notifications/:user_id
  def index
    @notifications = @user.notifications
    offset = params[:offset]
    limit = params[:limit]

    if offset.present?
      @notifications= @notifications.drop(offset.to_i)
    end

    if limit.present?
      @notifications = @notifications.first(limit.to_i)
    end

    render json: @notifications
  end

  # GET /notifications/:user_id/unread
  def index_unread
    ids = @user.notifications_users.where(looked: false).map { |x| x.notification_id }
    @notifications = @user.notifications.where(id: ids)
    offset = params[:offset]
    limit = params[:limit]

    if offset.present?
      @notifications= @notifications.drop(offset.to_i)
    end

    if limit.present?
      @notifications = @notifications.first(limit.to_i)
    end

    render json: @notifications
  end

  # PUT /notifications/:user_id/read_all
  def update
    if @user.notifications_users.update(:all, looked: true)
      render json: @user.notifications
    else
      render json: @user.notifications_users.errors, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

end

