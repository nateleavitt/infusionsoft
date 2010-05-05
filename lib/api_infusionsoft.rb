require "xmlrpc/client"

class InfusionsoftApiConnection
attr_accessor :api_url, :api_key

def initialize(url, key)
  @api_url = url
  @api_key = key
end

def api_perform(class_type, method, *args)
  begin
    server = XMLRPC::Client.new3({'host' => @api_url, 'path' => "/api/xmlrpc", 'port' => 443, 'use_ssl' => true})
    result = server.call("#{class_type}.#{method}", @api_key, *args)
  rescue XMLRPC::FaultException => e
    puts "*** Infusion Error: #{e.faultCode} - #{e.faultString} ***"
  end

  return result
end
end

module ApiInfusionsoft
  
  # Set account specific InfusionsoftApiConnection obj
  def self.set_account_apiconn(url, key)
    if ac = Thread.current[:api_conn]
      ac.api_url, ac.api_key = url, key
    else
      Thread.current[:api_conn] = InfusionsoftApiConnection.new(url, key)
    end
  end

  ########################
  ###  Email Service   ###
  ########################

  def api_email_optin(email, reason)
    # Enables you to opt contacts in
    Thread.current[:api_conn].api_perform('APIEmailService', 'optIn', email, reason)
  end

  def api_email_optout(email, reason)
    # Enables you to opt contacts out
    Thread.current[:api_conn].api_perform('APIEmailService', 'optOut', email, reason)
  end

  def api_email_send(contact_list, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
    # Sends an email through infusion
    Thread.current[:api_conn].api_perform('APIEmailService', 'sendEmail', contact_list, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
  end
  
  # adds an email template for future use
  # categories are a comma separated list of the categories you wan this template in Infusionsoft
  # content_type can be Text, HTML, Multipart
  # merge_context can be Contact, ServiceCall, Opportunity, CreditCard
  def api_email_add(title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
    Thread.current[:api_conn].api_perform('APIEmailService', 'addEmailTemplate', title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
  end

  def api_email_attach(contact_id, from_name, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body, header, receive_date, send_date)
    # Attaches an email to a contact record
    Thread.current[:api_conn].api_perform('APIEmailService', 'attachEmail', contact_id, from_name, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body, header, receive_date, send_date)
  end

  def api_email_create_template(title, user_id, from_address, to_addres, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
    # Creates an email template
    Thread.current[:api_conn].api_perform('APIEmailService', 'createEmailTemplate', title, user_id, from_address, to_addres, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
  end
  
  # updates an email template for future use
  # categories are a comma separated list of the categories you wan this template in Infusionsoft
  # content_type can be Text, HTML, Multipart
  # merge_context can be Contact, ServiceCall, Opportunity, CreditCard
  def api_email_update_template(id, title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
    Thread.current[:api_conn].api_perform('APIEmailService', 'updateEmailTemplate', title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type)
  end
  
  # returns an email template
  def api_email_get_template(id)
    Thread.current[:api_conn].api_perform('APIEmailService', 'getEmailTemplate', id)
  end
  
  # gets the opt-in status of the provided email address
  # 0 = opted out; 1 = single opt-in; 2 = double opt-in
  def api_email_get_opt_status(email_address)
    Thread.current[:api_conn].api_perform('APIEmailService', 'getOptStatus', email_address)
  end
  
  # returns a string of merge fields for a given context
  # context could include Contact, ServiceCall, Opportunity, CreditCard
  def api_email_get_available_merge_fields(merge_context)
    Thread.current[:api_conn].api_perform('APIEmailService', 'getAvailableMergeFields', merge_context)
  end

  ########################  
  ### Contact Service  ###
  ########################

  def api_contact_add(data)
    # Adds a contact to the database
    @contact_id = Thread.current[:api_conn].api_perform('ContactService', 'add', data)
    # Checks to see if email exists
    if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
    return @contact_id
  end

  def api_contact_add_recurring_order(contact_id, allow_duplicate, cprogram_id, merchant_account_id, credit_card_id, affiliate_id,
                        days_till_charge)
    # Creates a new recurring order for a contact.
    Thread.current[:api_conn].api_perform('ContactService','addRecurringOrder', contact_id, allow_duplicate, cprogram_id, 
                        merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
  end

  def api_contact_add_to_group(contact_id, group_id)
    # Adds a contact to a group
    Thread.current[:api_conn].api_perform('ContactService', 'addToGroup', contact_id, group_id)
  end

  def api_contact_link_contact(remoteApp, remoteId, localId)
    Thread.current[:api_conn].api_perform('ContactService', 'linkContact', remoteApp, remoteId, localId)
  end

  def api_contact_load(id, selected_fields)
    # Loads a contact from the database
    Thread.current[:api_conn].api_perform('ContactService', 'load', id, selected_fields)
  end

  def api_contact_locate_contact_link(locate_map_id)
    Thread.current[:api_conn].api_perform('ContactService', 'locateContactLink', locate_map_id)
  end

  def api_contact_mark_link_updated(locate_map_id)
    Thread.current[:api_conn].api_perform('ContactService', 'markLinkUpdated', locate_map_id)
  end

  def api_contact_add_to_campaign(contact_id, campaign_id)
    # Adds a contact to a campaign.
    Thread.current[:api_conn].api_perform('ContactService','addToCampaign', contact_id, campaign_id)
  end

  def api_contact_pause_campaign(contact_id, campaign_id)
    # Pauses a campaign for a given contact.
    Thread.current[:api_conn].api_perform('ContactService', 'pauseCampaign', contact_id, campaign_id)
  end

  def api_contact_remove_from_campaign(contact_id, campaign_id)
    # Removes a contact from a given campaign.
    Thread.current[:api_conn].api_perform('ContactService', 'removeFromCampaign', contact_id, campaign_id)
  end

  def api_contact_get_next_campaign_step(contact_id, campaign_id)
    # returns the next step in a campaign
    Thread.current[:api_conn].api_perform('ContactService', 'getNextCampaignStep', contact_id, campaign_id)
  end

  def api_contact_reschedule_campaign_step(list_of_contacts, campaign_id)
    # Reschedules a campaign step for a list of contacts
    Thread.current[:api_conn].api_perform('ContactService', 'reschedulteCampaignStep', list_of_contacts, campaign_id)
  end

  def api_contact_remove_from_group(contact_id, group_id)
    # Removes a contact from a given group.
    Thread.current[:api_conn].api_perform('ContactService', 'removeFromGroup', contact_id, group_id)
  end

  def api_contact_run_action_set(contact_id, action_set_id)
    # Executes an action sequence for a given contact
    Thread.current[:api_conn].api_perform('ContactService', 'runActionSequence', contact_id, action_set_id)
  end

  def api_contact_run_action_set_with_params(contact_id, action_set_id, params)
    # Executes an action sequence for a given contact, passing in
    # runtime params for running affiliate signup actions, etc
    Thread.current[:api_conn].api_perform('ContactService', 'runActionSequence', contact_id, action_set_id, params)
  end

  def api_contact_update(contact_id, data)
    # Updates a contact in the database.
    @bool = Thread.current[:api_conn].api_perform('ContactService', 'update', contact_id, data)
    if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
    return @bool
  end

  ########################  
  ###   Data Service   ###
  ########################

  def api_data_add(table, values)
    # Adds a record to the database
    # If you attempt to set fields that are marked read-only by the
    # Data Spec, this operation will simply ignore those fields - not
    # throw an error
    Thread.current[:api_conn].api_perform('DataService', 'add', table, values)
  end

  def api_data_find_by_field(table, limit, page, field_name, field_value, selected_fields)
    # This will locate all records in a given table that match the
    # criteria for a given field.
    Thread.current[:api_conn].api_perform('DataService', 'findByField', table, limit, page, field_name,
                        field_value, selected_fields)
  end

  def api_data_load(table, id, selected_fields)
    # This method will load a record from the database given the
    # primary key
    Thread.current[:api_conn].api_perform('DataService', 'load', table, id, selected_fields)
  end

  def api_data_query(table, limit, page, queryData, selected_fields)
    # Queries records in a given table to find matches on certain
    # fields
    Thread.current[:api_conn].api_perform('DataService', 'query', table, limit, page, queryData, selected_fields)
  end

  def api_data_update(table, id, values)
    # Updates a given record to the database
    Thread.current[:api_conn].api_perform('DataService', 'update', table, id, values)
  end

  def api_data_add_custom_field(context, label, data_type, group_id)
    # Adds a custom field to Infusionsoft
    Thread.current[:api_conn].api_perform('DataService', 'addCustomField', context, label, data_type, group_id)
  end

  def api_data_update_custom_field(field_id, field_value)
    # Updates a custom field
    Thread.current[:api_conn].api_perform('DataService', 'updateCustomField', field_id, field_value)
  end

  def api_data_authenticate_user(username, password)
    # Authenticates a user account in Infusionsoft
    Thread.current[:api_conn].api_perform('DataService', 'authenticateUser', username, password)
  end

  def api_data_echo(text)
    Thread.current[:api_conn].api_perform('DataService', 'echo', text)
  end

  ########################  
  ### Invoice Service  ###
  ########################
  
  def update_recurring_next_bill_date(job_recurring_id, new_bill_date) 
    Thread.current[:api_conn].api_perform('InvoiceService', 'updateJobRecurringNextBillDate', job_recurring_id, new_bill_date)
  end

  def api_invoice_add_manual_payment(invoice_id, amount, payment_date, payment_type, payment_description, bypass_commissions)
    # Make a manual payment to an invoice (can be a recurring invoice
    # or a one-time order invoice).
    Thread.current[:api_conn].api_perform('InvoiceService', 'addManualPayment', invoice_id, amount, payment_date, payment_type, 
                   payment_description, bypass_commissions)
  end

  def api_invoice_add_order_commission_override(invoice_id, affiliate_id, product_id, percentage, amount, payout_type, 
                                 description, date)
    # Adds a commission override to a one time order, using a
    # combination of percentage and hard-coded amounts.
    Thread.current[:api_conn].api_perform('InvoiceService', 'addOrderCommissionOverride', invoice_id, affiliate_id, product_id, 
                   percentage, amount, payout_type, description, date)
  end

  def api_invoice_add_order_item(order_id, product_id, type, price, quantity, description, notes)
    # Adds an item to an existing order.
    Thread.current[:api_conn].api_perform('InvoiceService', 'addOrderItem', order_id, product_id, type, price,
                   quantity, description, notes)
  end

  def api_invoice_add_payment_plan(order_id, auto_charge, credit_card_id, merchant_account_id, days_between_retry, max_retry,
                     initial_payment_amount, plan_start_date, number_of_payments, days_between_payments)
    # Adds a payment plan to an existing invoice.
    Thread.current[:api_conn].api_perform('InvoiceService', 'addPaymentPlan', order_id, auto_charge, credit_card_id, merchant_account_id, 
                   days_between_retry, max_retry, initial_payment_amount, plan_start_date, number_of_payments, 
                   days_between_payments)
  end

  def api_invoice_add_recurring_commission_override(recurringorder_id, affiliate_id, amount, payout_type, description)
    # Adds a commission override to a recurring order.
    Thread.current[:api_conn].api_perform('InvoiceService', 'addRecurringCommissionOverride', recurringorder_id, affiliate_id, amount, 
                   payout_type, description)
  end

  def api_invoice_add_recurring_order(contact_id, allow_duplicate, cprogram_id, merchant_account_id, credit_card_id, affiliate_id,
                        days_till_charge)
    # Adds a recurring order to the database.
    Thread.current[:api_conn].api_perform('InvoiceService', 'addRecurringOrder', contact_id, allow_duplicate, cprogram_id, 
                   merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
  end
  
  def api_invoice_add_recurring_order_with_price(contact_id, allow_duplicate, cprogram_id, qty, price, allow_tax, merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
    # Adds a recurring order to the database.
    Thread.current[:api_conn].api_perform('InvoiceService', 'addRecurringOrder', contact_id, allow_duplicate, cprogram_id, qty, price, allow_tax, merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
  end

  def api_invoice_calculate_amount_owed(invoice_id)
    # Calculates the amount owed for a given invoice.
    Thread.current[:api_conn].api_perform('InvoiceService', 'calculateAmountOwed', invoice_id)
  end

  def api_invoice_charge_invoice(invoice_id, notes, credit_card_id, merchant_account_id, bypass_commissions)
    # Will charge an invoice with the amount currently due on it.
    Thread.current[:api_conn].api_perform('InvoiceService', 'chargeInvoice', invoice_id, notes, credit_card_id, 
                        merchant_account_id, bypass_commissions)
  end

  def api_invoice_get_invoice_id(order_id)
    # returns the invoice id from a one time order
    Thread.current[:api_conn].api_perform('InvoiceService', 'getinvoice_id', order_id)
  end

  def api_invoice_create_blank_order(contact_id, description, order_date, lead_affiliate_id, sale_affiliate_id)
    # Creates a blank order with no items.
    Thread.current[:api_conn].api_perform('InvoiceService', 'createBlankOrder', contact_id, description, order_date, 
                        lead_affiliate_id, sale_affiliate_id)
  end

  def api_invoice_create_invoice_for_recurring(recurringorder_id)
    # This will create an invoice for all charges due on a recurring order.
    Thread.current[:api_conn].api_perform('InvoiceService', 'createInvoiceForRecurring', recurringorder_id)
  end

  def api_invoice_locate_existing_card(contact_id, last4)
    # Locates an existing card in the system for a contact, using the
    # last 4 digits of the card.
    Thread.current[:api_conn].api_perform('InvoiceService', 'locateExistingCard', contact_id, last4)
  end

  def api_invoice_validate_card(credit_card_id)
    # This will validate a credit card in the system.
    Thread.current[:api_conn].api_perform('InvoiceService', 'validateCreditCard', credit_card_id)
  end

  def api_invoice_validate_card(creditCard)
    # This will validate a credit card by passing in values of the
    # card directly (this card doesn't have to be added to the system)
    Thread.current[:api_conn].api_perform('InvoiceService', 'validateCreditCard', creditCard)
  end

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

  ########################  
  ###  Ticket Service  ###
  ########################

  def api_ticket_add_move_notes(ticket_list, move_notes, move_to_stage_id, notify_ids)
    # add move notes to existing tickets
    Thread.current[:api_conn].api_perform('ServiceCallService', 'addMoveNotes', ticket_list, move_notes, move_to_stage_id, notify_ids)
  end

  def api_ticket_move_stage(ticket_id, ticket_stage, move_notes, notify_ids)
    # add move notes to existing tickets
    Thread.current[:api_conn].api_perform('ServiceCallService', 'moveTicketStage', ticket_id, ticket_stage, move_notes, notify_ids)
  end
  
  ########################  
  ###  File Service  ###
  ########################
  
  def api_file_upload(contact_id, file_name, encoded_file_base64)
    Thread.current[:api_conn].api_perform('FileService', 'uploadFile', contact_id, file_name, encoded_file_base64)
  end
  
  # returns the Base64 encoded file contents
  def api_file_get(id)
    Thread.current[:api_conn].api_perform('FileService', 'getFile', id)
  end
  
  def api_file_url(id)
    Thread.current[:api_conn].api_perform('FileService', 'getDownloadUrl', id)
  end
  
  def api_file_rename(id, new_name)
    Thread.current[:api_conn].api_perform('FileService', 'renameFile', id, new_name)
  end
  
  def api_file_replace(id, encoded_file_base64)
    Thread.current[:api_conn].api_perform('FileService', 'replaceFile', id, encoded_file_base64)
  end
end