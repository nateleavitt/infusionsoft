module AffiliateService

  ########################  
  ### Affiliate Service ##
  ########################

  def api_affiliate_clawbacks(affiliate_id, start_date, end_date)
    # return all claw backs in a date range
    Thread.current[:api_conn].api_perform('APIAffiliateService', 'affClawbacks', affiliate_id, start_date, end_date)
  end

  def api_affiliate_commissions(affiliate_id, start_date, end_date)
    # return all commissions in a date range
    Thread.current[:api_conn].api_perform('APIAffiliateService', 'affCommissions', affiliate_id, start_date, end_date)
  end

  def api_affiliate_payouts(affiliate_id, start_date, end_date)
    # return all payouts in a date range
    Thread.current[:api_conn].api_perform('APIAffiliateService', 'affPayouts', affiliate_id, start_date, end_date)
  end

  def api_affiliate_running_totals(affiliate_list)
    # returns a list with each row representing a single affiliates totals represented by a map with key
    # one of the names above, and value being the total for the variable
    Thread.current[:api_conn].api_perform('APIAffiliateService', 'affRunningTotals', affiliate_list)
  end

  def api_affiliate_summary(affiliate_list, start_date, end_date)
    # return how much the specified affiliates are owed
    Thread.current[:api_conn].api_perform('APIAffiliateService', 'affSummary', affiliate_list, start_date, end_date)
  end
end
