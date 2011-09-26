module Infusionsoft
  class Client
    ########################  
    ### Invoice Service  ###
    ########################
    module Invoice
      def update_recurring_next_bill_date(job_recurring_id, new_bill_date) 
        response = get('InvoiceService', 'updateJobRecurringNextBillDate', job_recurring_id, new_bill_date)
      end

      # Make a manual payment to an invoice (can be a recurring invoice
      # or a one-time order invoice).
      def api_invoice_add_manual_payment(invoice_id, amount, payment_date, payment_type, payment_description, bypass_commissions)
        response = get('InvoiceService', 'addManualPayment', invoice_id, amount, payment_date, payment_type, 
                       payment_description, bypass_commissions)
      end

      # Adds a commission override to a one time order, using a
      # combination of percentage and hard-coded amounts.
      def api_invoice_add_order_commission_override(invoice_id, affiliate_id, product_id, percentage, amount, payout_type, 
                                     description, date)
        response = get('InvoiceService', 'addOrderCommissionOverride', invoice_id, affiliate_id, product_id, 
                       percentage, amount, payout_type, description, date)
      end

      # Adds an item to an existing order.
      def api_invoice_add_order_item(order_id, product_id, type, price, quantity, description, notes)
        response = get('InvoiceService', 'addOrderItem', order_id, product_id, type, price,
                       quantity, description, notes)
      end

      # Adds a payment plan to an existing invoice.
      def api_invoice_add_payment_plan(order_id, auto_charge, credit_card_id, merchant_account_id, days_between_retry, max_retry,
                         initial_payment_amount, plan_start_date, number_of_payments, days_between_payments)
        response = get('InvoiceService', 'addPaymentPlan', order_id, auto_charge, credit_card_id, merchant_account_id, 
                       days_between_retry, max_retry, initial_payment_amount, plan_start_date, number_of_payments, 
                       days_between_payments)
      end

      # Adds a commission override to a recurring order.
      def api_invoice_add_recurring_commission_override(recurringorder_id, affiliate_id, amount, payout_type, description)
        response = get('InvoiceService', 'addRecurringCommissionOverride', recurringorder_id, affiliate_id, amount, 
                       payout_type, description)
      end

      # Adds a recurring order to the database.
      def api_invoice_add_recurring_order(contact_id, allow_duplicate, cprogram_id, merchant_account_id, credit_card_id, affiliate_id,
                            days_till_charge)
        response = get('InvoiceService', 'addRecurringOrder', contact_id, allow_duplicate, cprogram_id, 
                       merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
      end
      
      # Adds a recurring order to the database.
      def api_invoice_add_recurring_order_with_price(contact_id, allow_duplicate, cprogram_id, qty, price, allow_tax, merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
        response = get('InvoiceService', 'addRecurringOrder', contact_id, allow_duplicate, cprogram_id, qty, price, allow_tax, merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
      end

      # Calculates the amount owed for a given invoice.
      def api_invoice_calculate_amount_owed(invoice_id)
        response = get('InvoiceService', 'calculateAmountOwed', invoice_id)
      end

      # Will charge an invoice with the amount currently due on it.
      def api_invoice_charge_invoice(invoice_id, notes, credit_card_id, merchant_account_id, bypass_commissions)
        response = get('InvoiceService', 'chargeInvoice', invoice_id, notes, credit_card_id, 
                            merchant_account_id, bypass_commissions)
      end

      # returns the invoice id from a one time order
      def api_invoice_get_invoice_id(order_id)
        response = get('InvoiceService', 'getinvoice_id', order_id)
      end

      # Creates a blank order with no items.
      def api_invoice_create_blank_order(contact_id, description, order_date, lead_affiliate_id, sale_affiliate_id)
        response = get('InvoiceService', 'createBlankOrder', contact_id, description, order_date, 
                            lead_affiliate_id, sale_affiliate_id)
      end

      # This will create an invoice for all charges due on a recurring order.
      def api_invoice_create_invoice_for_recurring(recurringorder_id)
        response = get('InvoiceService', 'createInvoiceForRecurring', recurringorder_id)
      end

      # Locates an existing card in the system for a contact, using the
      def api_invoice_locate_existing_card(contact_id, last4)
        # last 4 digits of the card.
        response = get('InvoiceService', 'locateExistingCard', contact_id, last4)
      end

      # This will validate a credit card in the system.
      def api_invoice_validate_card(credit_card_id)
        response = get('InvoiceService', 'validateCreditCard', credit_card_id)
      end

      # This will validate a credit card by passing in values of the
      # card directly (this card doesn't have to be added to the system)
      def api_invoice_validate_card(creditCard)
        response = get('InvoiceService', 'validateCreditCard', creditCard)
      end
    end
  end
end
