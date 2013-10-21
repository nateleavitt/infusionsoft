require 'infusionsoft/exceptions'

class Infusionsoft::ExceptionHandler

  ERRORS = {
      1 => Infusionsoft::InvalidConfigError,
      2 => Infusionsoft::InvalidKeyError,
      3 => Infusionsoft::UnexpectedError,
      4 => Infusionsoft::DatabaseError,
      5 => Infusionsoft::RecordNotFoundError,
      6 => Infusionsoft::LoadingError,
      7 => Infusionsoft::NoTableAccessError,
      8 => Infusionsoft::NoFieldAccessError,
      9 => Infusionsoft::NoTableFoundError,
      10 => Infusionsoft::NoFieldFoundError,
      11 => Infusionsoft::NoFieldsError,
      12 => Infusionsoft::InvalidParameterError,
      13 => Infusionsoft::FailedLoginAttemptError,
      14 => Infusionsoft::NoAccessError,
      15 => Infusionsoft::FailedLoginAttemptPasswordExpiredError
  }

  def initialize(xmlrpc_exception)
    error_class = ERRORS[xmlrpc_exception.faultCode]
    if error_class
      raise error_class, xmlrpc_exception.faultString
    else
      raise InfusionAPIError, xmlrpc_exception.faultString
    end
  end

end
