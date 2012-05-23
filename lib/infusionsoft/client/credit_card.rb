module Infusionsoft
  class Client
    # CreditCardSubmission service is used to obtain a token that is to be submitted 
    # through a form when adding a credit card. In accordance with PCI compliance, 
    # adding credit cards through the API will no longer be supported.
    module CreditCard

      # This service will request a token that will be used when submitting
      # a new credit card through a form
      #
      # @param [Integer] contact_id of the Infusionsoft contact
      # @param [String] url that will be redirected to upon successfully adding card
      # @param [String] url that will be redirected to when there is a failure upon adding card
      def credit_card_request_token(contact_id, success_url, failure_url)
        response = get('CreditCardSubmissionService.requestSubmissionToken', contact_id, success_url, failure_url)
      end

      def credit_card_lookup_by_token(token)
        response = get('CreditCardSubmissionService.requestCreditCardId', token)
      end

    end
  end
end
