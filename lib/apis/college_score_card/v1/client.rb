module Apis
  module CollegeScoreCard
    module V1
      class Client
        BASE_URL = "https://api.data.gov/ed/collegescorecard/v1"
        API_KEY = Rails.application.credentials.college_score_card.api_key

        def initialize
          @connection = Faraday.new(BASE_URL)
        end

        def search_colleges_by_name(college_name)
          query = "fields=id,school.name,location&school.name=#{college_name}"
          response = get("schools", query)

          parse_response(response)
        end

        private

        def get(resource, query)
          @connection.get("#{resource}?api_key=#{API_KEY}&#{query}")
        end

        def parse_response(response)
          json_response = JSON.parse(response.body)
          return json_response['results'] if response.success?
          
          error_message = "#{json_response.dig('error', 'code')}: #{json_response.dig('error', 'message')}"
          raise Error.new(error_message)
        end
      end
    end
  end
end
