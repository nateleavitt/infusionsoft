require 'test/test_helper'

class RestErrorHandlingTest < Test::Unit::TestCase
  def setup
    @client = Infusionsoft::Client.new('test_app_id', 'test_api_key')
  end

  def test_rest_error_handling_raises_proper_exception
    # Mock a failed REST request that would return a 400 error
    error_response = {
      "code" => 400,
      "message" => "contact_id is invalid",
      "status" => "Bad Request",
      "details" => [{"domain" => "paymentmethodconfig", "resource" => "POST /rest/v2/paymentMethodConfigs"}]
    }

        # Mock RestClient to raise an exception with our error response
    mock_response = mock
    mock_response.expects(:code).returns(400)
    mock_response.expects(:body).returns(error_response.to_json)

    mock_exception = RestClient::BadRequest.new(mock_response)

    # Test that the error is properly handled and raises the correct exception
    assert_raises(Infusionsoft::InvalidParameterError) do
      @client.send(:handle_rest_error, mock_exception)
    end
  end

  def test_rest_error_handling_with_different_status_codes
        # Test 401 Unauthorized
    error_response_401 = {"code" => 401, "message" => "Invalid token"}
    mock_response_401 = mock
    mock_response_401.expects(:code).returns(401)
    mock_response_401.expects(:body).returns(error_response_401.to_json)

    mock_exception_401 = RestClient::Unauthorized.new(mock_response_401)

    assert_raises(Infusionsoft::FailedLoginAttemptError) do
      @client.send(:handle_rest_error, mock_exception_401)
    end

        # Test 404 Not Found
    error_response_404 = {"code" => 404, "message" => "Record not found"}
    mock_response_404 = mock
    mock_response_404.expects(:code).returns(404)
    mock_response_404.expects(:body).returns(error_response_404.to_json)

    mock_exception_404 = RestClient::ResourceNotFound.new(mock_response_404)

    assert_raises(Infusionsoft::RecordNotFoundError) do
      @client.send(:handle_rest_error, mock_exception_404)
    end
  end

  def test_rest_error_handling_with_invalid_json
        # Test handling of non-JSON error responses
    mock_response = mock
    mock_response.expects(:code).returns(500)
    mock_response.expects(:body).returns("Internal Server Error")

    mock_exception = RestClient::InternalServerError.new(mock_response)

    # Should fall back to UnexpectedError with the original error message
    assert_raises(Infusionsoft::UnexpectedError) do
      @client.send(:handle_rest_error, mock_exception)
    end
  end
end