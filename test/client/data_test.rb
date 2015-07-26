require_relative('../test_helper')

class DataTest < Test::Unit::TestCase

  def test_data_add
    data_hash = { Company: 'Hogwarts of America', Phone1: '123-456-7899',
                  Website: 'http://hogwarts-usa.com', StreetAddress1: '123 Wizard Ave.',
                  City: 'Redmond', State: 'WA', PostalCode: '98052',
                  Country: 'United States' }
    VCR.use_cassette('data_add') do
      result = Infusionsoft.data_add('Company', data_hash)
      assert_instance_of Fixnum, result
    end
  end

  def test_data_load
    desired_fields = [:Company, :StreetAddress1, :City, :State, :PostalCode, :Country]
    expected_fields = desired_fields.map { |f| f.to_s }.sort
    VCR.use_cassette('data_load') do
      result = Infusionsoft.data_load('Company', 3618, desired_fields)
      assert_equal result.keys.sort, expected_fields
    end
  end

  def test_data_update
    update_hash = { Phone1: '(987) 654-3211' }
    VCR.use_cassette('data_update') do
      result = Infusionsoft.data_update('Company', 3618, update_hash)
      assert_equal result, 3618
      assert_equal Infusionsoft.data_load('Company', 3618, [:Phone1])['Phone1'], update_hash[:Phone1]
    end
  end

  def test_data_delete
    VCR.use_cassette('data_delete') do
      result = Infusionsoft.data_delete('Company', 3618)
      assert_true result
    end
  end

  def test_data_find_by_field
    VCR.use_cassette('data_find_by_field') do
      result = Infusionsoft.data_find_by_field('Company', 5, 0, :Company, 'Hogwarts of America', [:Id, :Company])
      assert_instance_of Array, result
      assert_compare result.size, :>, 0
    end
  end

  def test_data_query
    VCR.use_cassette('data_query') do
      result = Infusionsoft.data_query('Company', 5, 0, { :Company => 'Hogwarts of America' }, [:Id, :Company])
      assert_instance_of Array, result
      assert_compare result.size, :>, 0
    end
  end

  def test_data_query_order_by
    VCR.use_cassette('data_query_order_by') do
      result = Infusionsoft.data_query_order_by('Company', 5, 0, { :Company => 'Hogwarts of America' }, [:Id, :Company], :Id, false)
      assert_instance_of Array, result
      assert_compare result.size, :>, 0
      assert_compare result.first['Id'].to_i, :>, result.last['Id'].to_i
    end
  end

  def test_data_add_custom_field
    VCR.use_cassette('data_add_custom_field') do
      result = Infusionsoft.data_add_custom_field('Company', 'Awesomeness Level', 'Text', 4)
      assert_instance_of Fixnum, result
    end
  end

  def test_data_auth_user_success
    password = Digest::MD5.new.hexdigest 'good_pass'
    VCR.use_cassette('data_auth_user_success') do
      result = Infusionsoft.data_authenticate_user('test@test.com', password)
      assert_instance_of Fixnum, result
    end
  end

  def test_data_auth_user_failure
    VCR.use_cassette('data_auth_user_failure') do
      assert_raise_kind_of Infusionsoft::FailedLoginAttemptError do
        Infusionsoft.data_authenticate_user('test@test.com', 'bad_pass')
      end
    end
  end

  def test_data_update_custom_field
    VCR.use_cassette('data_update_custom_field') do
      result = Infusionsoft.data_update_custom_field(16, {:Label => 'Stuff'} )
      assert_true result
    end
  end

  def test_data_get_app_setting
    VCR.use_cassette('data_get_app_setting') do
      result = Infusionsoft.data_get_app_setting('Contact', 'optiontitles')
      assert_not_nil result
    end
  end
end