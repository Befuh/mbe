module APIHelper
  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def json_response!
    @json_response = JSON.parse(response.body)
  end
end
