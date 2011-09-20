module InvoiceService

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
end
