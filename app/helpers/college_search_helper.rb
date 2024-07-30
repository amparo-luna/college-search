module CollegeSearchHelper
  def college_data_params(college_result)
    { 
      action: "click->map#updateMap", 
      map_lat_value: college_result['location.lat'], 
      map_lng_value: college_result['location.lon'] 
    }
  end
end
