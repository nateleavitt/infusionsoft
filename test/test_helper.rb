require 'coveralls'
Coveralls.wear!

require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '/vendor/'
  add_filter '/.bundle/'
  add_filter '/test'
  add_group 'Clients', 'lib/infusionsoft/client'
end

require 'test/unit'
require 'infusionsoft'

require 'vcr'
require 'webmock/test_unit'
require 'mocha/test_unit'

WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { record: :once, match_requests_on: [:method] }
end

class Test::Unit::TestCase
  class TestLogger
    def info(msg); end
    def warn(msg); end
    def error(msg); end
    def debug(msg); end
    def fatal(msg); end
  end

  def setup
    Infusionsoft.configure do |config|
      config.api_url = 'test.infusionsoft.com'
      config.api_key = 'not_a_real_key'
      config.api_logger = TestLogger.new
    end
  end
end
