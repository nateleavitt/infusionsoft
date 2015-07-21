require_relative('test_helper')

class ExceptionsTest < Test::Unit::TestCase

  def setup
    super
    @test_exc_msg = 'Some error message'
  end

  def test_should_raise_invalid_config
    stub_client_call(1)
    assert_raise_kind_of Infusionsoft::InvalidConfigError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_invalid_key
    stub_client_call(2)
    assert_raise_kind_of Infusionsoft::InvalidKeyError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_unexpected_error
    stub_client_call(3)
    assert_raise_kind_of Infusionsoft::UnexpectedError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_database_error
    stub_client_call(4)
    assert_raise_kind_of Infusionsoft::DatabaseError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_record_not_found
    stub_client_call(5)
    assert_raise_kind_of Infusionsoft::RecordNotFoundError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_loading_error
    stub_client_call(6)
    assert_raise_kind_of Infusionsoft::LoadingError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_no_table_access
    stub_client_call(7)
    assert_raise_kind_of Infusionsoft::NoTableAccessError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_no_field_access
    stub_client_call(8)
    assert_raise_kind_of Infusionsoft::NoFieldAccessError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_no_table_found
    stub_client_call(9)
    assert_raise_kind_of Infusionsoft::NoTableFoundError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_no_field_found
    stub_client_call(10)
    assert_raise_kind_of Infusionsoft::NoFieldFoundError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_no_fields_error
    stub_client_call(11)
    assert_raise_kind_of Infusionsoft::NoFieldsError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_invalid_parameter_error
    stub_client_call(12)
    assert_raise_kind_of Infusionsoft::InvalidParameterError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_failed_login_attempt
    stub_client_call(13)
    assert_raise_kind_of Infusionsoft::FailedLoginAttemptError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_no_access_error
    stub_client_call(14)
    assert_raise_kind_of Infusionsoft::NoAccessError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_failed_login_attempt_password_expired
    stub_client_call(15)
    assert_raise_kind_of Infusionsoft::FailedLoginAttemptPasswordExpiredError do
      run_exceptional_data_query
    end
  end

  def test_should_raise_infusionapierror_when_fault_code_unknown
    stub_client_call(42)
    assert_raise_kind_of InfusionAPIError do
      run_exceptional_data_query
    end
  end

  private

  def stub_client_call(exception_num)
    XMLRPC::Client.any_instance.stubs(:call).raises(XMLRPC::FaultException.new(exception_num, @test_exc_msg))
  end

  def run_exceptional_data_query
    Infusionsoft.data_query(:Contact, 1, 0, {}, [:BlahdyDah])
  end
end
