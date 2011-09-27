module Infusionsoft
  class Client
    # The Affiliate service is used to pull commission data and activities for affiliates.
    # With this service, you have access to Clawbacks, Commissions, Payouts, Running Totals,
    # and the Activity Summary. The methods in the Affiliate service mirror the reports
    # produced inside Infusionsoft.
    #
    # @note To manage affiliate information (ie Name, Phone, etc.) you will need to use the Data service.
    module Affiliate
      # Used when you need to retrieve all clawed back commissions for a particular affiliate.
      #
      # @param [Integer] affiliate_id
      # @params [Date] start_date
      # @end_date [Date] end_date
      # @return [Array] all claw backs for the given affiliate that have occurred within the date
      #   range specified
      def affiliate_clawbacks(affiliate_id, start_date, end_date)
        response = get('APIAffiliateService.affClawbacks', affiliate_id, start_date, end_date)
      end

      # Used to retrieve all commissions for a specific affiliate within a date range.
      #
      # @param [Integer] affiliate_id
      # @param [Date] start_date
      # @param [Date] end_date
      # @return [Array] all sales commissions for the given affiliate earned within the date range
      #   specified
      def affiliate_commissions(affiliate_id, start_date, end_date)
        response = get('APIAffiliateService.affCommissions', affiliate_id, start_date, end_date)
      end

      # Used to retrieve all payments for a specific affiliate within a date range.
      #
      # @param [Integer] affiliate_id
      # @param [Date] start_date
      # @param [Date] end_date
      # @return [Array] a list of rows, each row is a single payout
      def affiliate_payouts(affiliate_id, start_date, end_date)
        response = get('APIAffiliateService.affPayouts', affiliate_id, start_date, end_date)
      end

      # This method is used to retrieve all commissions for a specific affiliate within a date range.
      #
      # @param [Array] affiliate_list
      # @return [Array] all sales commissions for the given affiliate earned within the date range
      #   specified
      def affiliate_running_totals(affiliate_list)
        response = get('APIAffiliateService.affRunningTotals', affiliate_list)
      end

      # Used to retrieve a summary of statistics for a list of affiliates.
      #
      # @param [Array] affiliate_list
      # @param [Date] start_date
      # @param [Date] end_date
      # @return [Array<Hash>] a summary of the affiliates information for a specified date range
      def affiliate_summary(affiliate_list, start_date, end_date)
        response = get('APIAffiliateService.affSummary', affiliate_list, start_date, end_date)
      end
    end
  end
end
