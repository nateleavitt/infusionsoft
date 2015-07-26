require_relative('../test_helper')

class EmailTest < Test::Unit::TestCase

  def test_email_add
    VCR.use_cassette('email_add') do
      result = Infusionsoft.email_add('Test Via API', 'test,api', 'noreply@test.com',
                                      'test@test.com', 'test2@test.com', 'test3@test.com',
                                      'Test Subject', 'Text Body', '<p> HTML body',
                                      'Multipart', 'Contact')
      assert_instance_of Fixnum, result
    end
  end

  def test_email_attach
    VCR.use_cassette('email_attach') do
      result = Infusionsoft.email_attach(304, 'The Dude', 'the_dude@lebowski.com',
                                         'hagglundized@gmail.com', 'hagglundized+cc@gmail.com',
                                         'hagglundized+bcc@gmail.com', 'Multipart', 'Question',
                                         "<em>Where's the money?</em>", "Where's the money?",
                                         'Test Header', DateTime.now.to_s, DateTime.now.to_s)
      assert_true result
    end
  end

  def test_email_get_available_merge_fields
    VCR.use_cassette('email_get_available_merge_fields') do
      result = Infusionsoft.email_get_available_merge_fields('Contact')
      assert_instance_of Array, result
    end
  end

  def test_email_get_template
    VCR.use_cassette('email_get_template') do
      result = Infusionsoft.email_get_template(3649)
      assert_instance_of Hash, result
    end
  end

  def test_email_get_opt_status
    VCR.use_cassette('email_get_opt_status') do
      result = Infusionsoft.email_get_opt_status('hagglundized@gmail.com')
      assert_instance_of Fixnum, result
    end
  end

  def test_email_optin
    VCR.use_cassette('email_optin') do
      result = Infusionsoft.email_optin('hagglundized@gmail.com', 'because i said so')
      assert_true [true, false].include? result
    end
  end

  def test_email_optout
    VCR.use_cassette('email_optout') do
      result = Infusionsoft.email_optout('boutthat@ction.boss', 'because i said so')
      assert_true [true, false].include? result
    end
  end

  def test_email_send
    VCR.use_cassette('email_send') do
      result = Infusionsoft.email_send([304], 'the_dude@lebowski.com',
                                         'hagglundized@gmail.com', 'hagglundized+cc@gmail.com',
                                         'hagglundized+bcc@gmail.com', 'Multipart', 'Question',
                                         "<em>Where's the money?</em>", "Where's the money?")
      assert_true [true, false].include? result
    end
  end

  def test_email_send_template
    VCR.use_cassette('email_send_template') do
      result = Infusionsoft.email_send_template([304], '3649')
      assert_true [true, false].include? result
    end
  end

  def test_email_update_template
    VCR.use_cassette('email_update_template') do
      result = Infusionsoft.email_update_template(3649, 'Testingness Testagram', '', '',
                                                  'hagglundized@gmail.com',
                                                  'hagglundized+cc@gmail.com',
                                                  'hagglundized+bcc@gmail.com',
                                                  'Testingness Testagrams', 'Stuff',
                                                  '<em>Stuff</em>', 'Multipart', 'Contact')
      assert_true [true, false].include? result
    end
  end
end