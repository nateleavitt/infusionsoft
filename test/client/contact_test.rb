require_relative('../test_helper')

class ContactTest < Test::Unit::TestCase

  def test_contact_add
    data_hash = { Email: 'test@tester.com', FirstName: 'Severus', LastName: 'Snape' }
    VCR.use_cassette('contact_add') do
      result = Infusionsoft.contact_add(data_hash)
      assert_instance_of Fixnum, result
    end
  end

  def test_contact_merge
    VCR.use_cassette('contact_merge') do
      result = Infusionsoft.contact_merge(3602, 3604)
      assert_true result
    end
  end

  def test_contact_add_dup_check_with_dup
    data_hash = { Email: 'test@tester.com', FirstName: 'Severus',
                  LastName: 'Snape', Company: 'Test Company' }
    VCR.use_cassette('contact_add_dup_check_with_dup') do
      existing_contact = Infusionsoft.contact_load(3606, [:Id, :FirstName, :LastName, :Email, :Company])
      result = Infusionsoft.contact_add_with_dup_check(data_hash, 'EmailAndName')
      assert_equal result, existing_contact['Id']
      assert_equal Infusionsoft.contact_load(existing_contact['Id'], [:Company])['Company'], data_hash[:Company]
    end
  end

  def test_contact_add_dup_check_no_dup
    data_hash = { Email: 'new@tester.com', FirstName: 'Albus',
                  LastName: 'Dumbledore', Company: 'Hogwarts' }
    VCR.use_cassette('contact_add_dup_check_no_dup') do
      result = Infusionsoft.contact_add_with_dup_check(data_hash, 'EmailAndNameAndCompany')
      assert_instance_of Fixnum, result
    end
  end

  def test_contact_load
    desired_fields = [:FirstName, :LastName]
    expected_fields = desired_fields.map { |f| f.to_s }.sort
    VCR.use_cassette('contact_load') do
      result = Infusionsoft.contact_load(3606, desired_fields)
      assert_equal result.keys.sort, expected_fields
    end
  end

  def test_contact_update
    data_hash = { Company: 'Hogwarts' }
    VCR.use_cassette('contact_update') do
      result = Infusionsoft.contact_update(3606, data_hash)
      assert_equal result, 3606
      assert_equal Infusionsoft.contact_load(3606, [:Company])['Company'], data_hash[:Company]
    end
  end

  def test_contact_find_by_email
    VCR.use_cassette('find_by_email') do
      result = Infusionsoft.contact_find_by_email('test@tester.com', [:Id])
      assert_instance_of Array, result
      assert_instance_of Hash, result.first
    end
  end

  def test_contact_add_to_group
    VCR.use_cassette('add_to_group') do
      result = Infusionsoft.contact_add_to_group(3794, 382)
      assert_true result
    end
  end

  def test_contact_remove_from_group
    VCR.use_cassette('remove_from_group') do
      result = Infusionsoft.contact_remove_from_group(3794, 382)
      assert_true result
    end
  end
end
