# frozen_string_literal: true

class SearchFiltersController < ApplicationController
  before_action :set_search_filter, only: %i[show edit update destroy]
  before_action :set_search_events, only: [:show]

  # GET /search_filters
  def index
    @search_filters = current_user.search_filters
  end

  # GET /search_filters/1
  def show; end

  # GET /search_filters/new
  def new
    @search_filter = SearchFilter.new
  end

  # GET /search_filters/1/edit
  def edit; end

  # POST /search_filters
  def create
    @search_filter = SearchFilter.new(search_filter_params)
    if @search_filter.save
      redirect_to @search_filter, notice: 'Search filter was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /search_filters/1
  def update
    if @search_filter.update(search_filter_params)
      redirect_to @search_filter, notice: 'Search filter was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /search_filters/1
  def destroy
    @search_filter.destroy
    redirect_to search_filters_url, notice: 'Search filter was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_search_filter
    @search_filter = SearchFilter.find_by!(id: params[:id], user_id: current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def search_filter_params
    params.require(:search_filter).permit(:user_id, :city_id, :start_date, :end_date, :topic_id)
  end

  def set_search_events
    @events = Event.search(@search_filter.city_id, @search_filter.start_date, @search_filter.end_date, @search_filter.topic_id)
  end
end
