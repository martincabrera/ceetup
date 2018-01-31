require 'rails_helper'

RSpec.describe "SearchFilters", type: :request do
  describe "GET /search_filters" do
    it "works! (now write some real specs)" do
      get search_filters_path
      expect(response).to have_http_status(200)
    end
  end
end
