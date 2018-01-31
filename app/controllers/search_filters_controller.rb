class SearchFiltersController < ApplicationController
  before_action :set_search_filter, only: [:show, :edit, :update, :destroy]

  # GET /search_filters
  # GET /search_filters.json
  def index
    @search_filters = SearchFilter.all
  end

  # GET /search_filters/1
  # GET /search_filters/1.json
  def show
  end

  # GET /search_filters/new
  def new
    @search_filter = SearchFilter.new
  end

  # GET /search_filters/1/edit
  def edit
  end

  # POST /search_filters
  # POST /search_filters.json
  def create
    @search_filter = SearchFilter.new(search_filter_params)

    respond_to do |format|
      if @search_filter.save
        format.html { redirect_to @search_filter, notice: 'Search filter was successfully created.' }
        format.json { render :show, status: :created, location: @search_filter }
      else
        format.html { render :new }
        format.json { render json: @search_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_filters/1
  # PATCH/PUT /search_filters/1.json
  def update
    respond_to do |format|
      if @search_filter.update(search_filter_params)
        format.html { redirect_to @search_filter, notice: 'Search filter was successfully updated.' }
        format.json { render :show, status: :ok, location: @search_filter }
      else
        format.html { render :edit }
        format.json { render json: @search_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_filters/1
  # DELETE /search_filters/1.json
  def destroy
    @search_filter.destroy
    respond_to do |format|
      format.html { redirect_to search_filters_url, notice: 'Search filter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_filter
      @search_filter = SearchFilter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_filter_params
      params.require(:search_filter).permit(:user_id, :city_id, :start_date, :end_date, :topic_id)
    end
end
