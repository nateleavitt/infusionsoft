require 'test/unit'
require 'infusionsoft'


# override XMLRPC call method
class XMLRPC::Client

  def call(method, *args)
    raise XMLRPC::FaultException.new(@@code, @@message)
  end

  def self.set_fault_response(code, message)
    @@code = code
    @@message = message
  end
end

class TestLogger
  def info(msg); end
  def warn(msg); end
  def error(msg); end
  def debug(msg); end
  def fatal(msg); end
end


class TestExceptions < Test::Unit::TestCase

  def setup
    Infusionsoft.configure do |c|
      c.api_logger = TestLogger.new()
    end
  end

  def test_should_raise_invalid_config
    exception_test(Infusionsoft::InvalidConfigError, 1, 'The configuration for the application is invalid.  Usually this is because there has not been a passphrase entered to generate an encrypted key.')
  end

  def test_should_raise_invalid_key
    exception_test(Infusionsoft::InvalidKeyError, 2, "The key passed up for authentication was not valid.  It was either empty or didn't match.")
  end

  def test_should_raise_unexpected_error
    exception_test(Infusionsoft::UnexpectedError, 3, "An unexpected error has occurred.  There was either an error in the data you passed up or there was an unknown error on")
  end

  def test_should_raise_database_error
    exception_test(Infusionsoft::DatabaseError, 4, "There was an error in the database access")
  end

  def test_should_raise_record_not_found
    exception_test(Infusionsoft::RecordNotFoundError, 5, "A requested record was not found in the database.")
  end
  
  def test_should_raise_loading_error
    exception_test(Infusionsoft::LoadingError, 6, "There was a problem loading a record from the database.")
  end

  def test_should_raise_no_table_access
    exception_test(Infusionsoft::NoTableAccessError, 7, "A table was accessed without the proper permission")
  end

  def test_should_raise_no_field_access
    exception_test(Infusionsoft::NoFieldAccessError, 8, "A field was accessed without the proper permission.")
  end

  def test_should_raise_no_table_found
    exception_test(Infusionsoft::NoTableFoundError, 9, "A table was accessed that doesn't exist in the Data Spec.")
  end

  def test_should_raise_no_field_found
    exception_test(Infusionsoft::NoFieldFoundError, 10, "A field was accessed that doesn't exist in the Data Spec.")
  end

  def test_should_raise_no_fields_error
    exception_test(Infusionsoft::NoFieldsError, 11, "An update or add operation was attempted with no valid fields to update or add.")
  end

  def test_should_raise_invalid_parameter_error
    exception_test(Infusionsoft::InvalidParameterError, 12, "Data sent into the call was invalid.")
  end

  def test_should_raise_failed_login_attempt
    exception_test(Infusionsoft::FailedLoginAttemptError, 13, "Someone attempted to authenticate a user and failed.")
  end

  def test_should_raise_no_access_error
    exception_test(Infusionsoft::NoAccessError, 14, "Someone attempted to access a plugin they are not paying for.")
  end

  def test_should_raise_failed_login_attempt_password_expired
    exception_test(Infusionsoft::FailedLoginAttemptPasswordExpiredError, 15, "Someone attempted to authenticate a user and the password is expired.")
  end

  def test_should_raise_infusionapierror_when_fault_code_unknown
    exception_test(InfusionAPIError, 42, "Some random error occurred")
  end


  private
  def exception_test(exception, code, message)
    XMLRPC::Client.set_fault_response(code, message)
    caught = false
    begin
      Infusionsoft.data_query(:Contact, 1, 0, {}, [:BlahdyDah])
    rescue exception => e
      caught = true
      assert_equal message, e.message
    end
    assert_equal true, caught
  end

end
