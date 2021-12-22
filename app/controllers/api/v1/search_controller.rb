class Api::V1::SearchController < ApplicationController
  before_action :set_query, only: [:users, :events, :courses, :faculties]
  # GET /users
  def users
    output = User.all.filter do |x|
      @query.include?(x.first_name) or
      @query.include?(x.second_name)
    end
    render_output(output)
  end

  # GET /users
  def events
    output = Event.all.filter { |x| @query.include?(x.name) }
    render_output(output)
  end

  def render_output(output)
    offset = params[:offset]
    limit = params[:limit]

    if offset.present?
      output= output.drop(offset.to_i)
    end

    if limit.present?
      output = output.first(limit.to_i)
    end

    render json: output
  end

  private
  def search_params
    params.permit(:q)
  end

  def set_query
    @query = search_params[:q]
  end
end

