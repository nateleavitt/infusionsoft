# Extend StandardError to keep track of Error being wrapped
# Pattern from Exceptional Ruby by Avdi Grimm (http://avdi.org/talks/exceptional-ruby-2011-02-04/)
class InfusionAPIError < StandardError
  attr_reader :original
  def initialize(msg, original=nil);
  Infusionsoft.api_logger.error "ERROR: #{msg}"
  super(msg);
  @original = original;
  end
end

module Infusionsoft
  # For now I'm inheriting from InfusionAPIError so that the code will remain backwards compatible...may be deprecated in the future
  class InvalidConfigError < InfusionAPIError
  end

  class InvalidKeyError < InfusionAPIError
  end

  class UnexpectedError < InfusionAPIError
  end

  class DatabaseError < InfusionAPIError
  end

  class RecordNotFoundError < InfusionAPIError
  end

  class LoadingError < InfusionAPIError
  end

  class NoTableAccessError < InfusionAPIError
  end

  class NoFieldAccessError < InfusionAPIError
  end

  class NoTableFoundError < InfusionAPIError
  end

  class NoFieldFoundError < InfusionAPIError
  end

  class NoFieldsError < InfusionAPIError
  end

  class InvalidParameterError < InfusionAPIError
  end

  class FailedLoginAttemptError < InfusionAPIError
  end

  class NoAccessError < InfusionAPIError
  end

  class FailedLoginAttemptPasswordExpiredError < InfusionAPIError
  end
end
