require 'test_helper'
require "support/api_stubs"

class Apis::CollegeScoreCard::V1::ClientTest < ActiveSupport::TestCase
  include ApiStubs

  setup do
    @api_client = Apis::CollegeScoreCard::V1::Client.new
  end

  test "search colleges by name finds colleges matching the given name" do
    stub_const(Apis::CollegeScoreCard::V1::Client, :API_KEY, ApiStubs::API_KEY) do
      search_term = "Hogwarts"
      stub_successful_api_response(search_term)
      result = @api_client.search_colleges_by_name(search_term)

      assert_equal 2, result.size
    end
  end

  test "search colleges by name returns an empty array if no matching college is found" do
    stub_const(Apis::CollegeScoreCard::V1::Client, :API_KEY, ApiStubs::API_KEY) do
      search_term = "Princeton"
      stub_succesful_empty_api_response(search_term)
      result = @api_client.search_colleges_by_name(search_term)

      assert_predicate result, :empty?
    end
  end

  test "search colleges by name raises an error if the api response is not successful" do
    stub_const(Apis::CollegeScoreCard::V1::Client, :API_KEY, ApiStubs::API_KEY) do
      search_term = "Berkley"
      stub_invalid_api_key_response(search_term)

      assert_raises(Apis::CollegeScoreCard::V1::Error) do
        @api_client.search_colleges_by_name(search_term)
      end
    end
  end
end
