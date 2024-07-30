class CollegeSearchController < ApplicationController
  def index
    @search_term = search_params[:term]

    if @search_term
      begin
        @colleges = college_search
      rescue Apis::CollegeScoreCard::V1::Error => error
        redirect_to college_search_path, alert: error.message and return
      end
    end
  end

  private

  def search_params
    params.fetch(:search, {}).permit(:term)
  end

  def college_search
    client = Apis::CollegeScoreCard::V1::Client.new
    client.search_colleges_by_name(@search_term)
  end
end
