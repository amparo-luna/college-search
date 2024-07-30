require "test_helper"
require "support/api_stubs"

class CollegeSearchControllerTest < ActionDispatch::IntegrationTest
  include ApiStubs

  test "should get search page" do
    get college_search_url
    assert_response :success
  end

  test "should get college results from search term" do
    stub_const(Apis::CollegeScoreCard::V1::Client, :API_KEY, ApiStubs::API_KEY) do
      search_term = "Hogwarts"
      stub_successful_api_response(search_term)
  
      get college_search_url, params: { search: { term: search_term } }
      assert_response :success

      assert_select "ul.list-group" do
        assert_select "li", 2
      end
    end
  end

  test "should display only a message if there are no search results" do
    stub_const(Apis::CollegeScoreCard::V1::Client, :API_KEY, ApiStubs::API_KEY) do
      search_term = "Princetom"
      stub_succesful_empty_api_response(search_term)
  
      get college_search_url, params: { search: { term: search_term } }
      assert_response :success

      assert_select "ul.list-group" do
        assert_select "li", count: 1, text: "No results found"
      end
    end
  end

  test "should redirect and display an alert message if the api response is not successful" do
    stub_const(Apis::CollegeScoreCard::V1::Client, :API_KEY, ApiStubs::API_KEY) do
      search_term = "Berkley"
      stub_invalid_api_key_response(search_term)
  
      get college_search_url, params: { search: { term: search_term } }
      assert_redirected_to college_search_url
      assert_match "API_KEY_INVALID", flash[:alert]
    end
  end
end
