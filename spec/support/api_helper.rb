module APIHelper
  def with_required_params(params = {})
    params
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def json_response!
    @json_response = JSON.parse(response.body)
  end
end
