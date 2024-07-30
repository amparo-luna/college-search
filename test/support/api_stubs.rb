module ApiStubs
  BASE_URL = "#{Apis::CollegeScoreCard::V1::Client::BASE_URL}/schools"
  API_KEY = "test-api-key"

  def stub_schools_request(college_name, response)
    url = "#{BASE_URL}?api_key=#{API_KEY}&fields=id,school.name,location&school.name=#{college_name}"    
    stub_request(:get, url).to_return(response)
  end

  def stub_successful_api_response(college_name)
    results = [
      {
        "school.name": "#{college_name} Seminary",
        "id": 1,
        "location.lat": 40.35,
        "location.lon": -75.6
      },
      {
        "school.name": "#{college_name} University", 
        "id": 2, 
        "location.lat": 40.348732, 
        "location.lon": -74.659365
      }
    ]

    stub_schools_request(college_name, successful_response_json(results))
  end

  def stub_succesful_empty_api_response(college_name)
    stub_schools_request(college_name, successful_response_json([]))
  end

  def stub_invalid_api_key_response(college_name)
    error_response = {
      status: 403,
      body: {
        error: {
          code: "API_KEY_INVALID",
          message: "An invalid api_key was supplied."
        }
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
    stub_schools_request(college_name, error_response)
  end

  def successful_response_json(results)
    {
      status: 200,
      body: {
        metadata: { page: 0, total: results.size, per_page: 10 },
        results: results
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
  end
end
