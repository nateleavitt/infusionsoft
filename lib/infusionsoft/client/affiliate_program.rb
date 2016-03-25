module Infusionsoft
  class Client
    # The Affiliate Program Service allows access to some of features in the Referral Partner Center
    module AffiliateProgram
      # Retrieves a list of all of the Affiliate Programs that are in the application.
      #
      # @return [Array] all affiliate programs
      def affiliate_program_all()
        response = get('AffiliateProgramService.getAffiliatePrograms')
      end

      # Retrieves a list of all of the affiliates with their contact data for the specified program. 
      # This includes all of the custom fields defined for the contact and affiliate records that are 
      # retrieved.
      #
      # @param [Integer] program_id the Referral Partner Commission Program ID 
      # @return [Array] all affiliates associated with the given program_id
      def affiliate_program_affiliates(program_id)
        response = get('AffiliateProgramService.getAffiliatesByProgram', program_id)
      end

      # Retrieves a list of all of the Affiliate Programs for the Affiliate specified.
      #
      # @param [Integer] affiliate_id the affiliate you want to get the programs for 
      # @return [Array] all programs the given affiliate_id is associated with
      def affiliate_program_for_affiliate(affiliate_id)
        response = get('AffiliateProgramService.getProgramsForAffiliate', affiliate_id)
      end

      # Retrieves a list of all of the resources that are associated to the Affiliate Program specified.
      #
      # @param [Integer] program_id the commission program you want resources from
      # @return [Array] all resources for the given commission program_id
      def affiliate_program_resources(program_id)
        response = get('AffiliateProgramService.getResourcesForAffiliateProgram', program_id)
      end
    end
  end
end
