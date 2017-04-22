module Infusionsoft
  class Client
    # The Invoice service allows you to manage eCommerce transactions.
    module Invoice
      # Creates a blank order with no items.
      #
      # @param [Integer] contact_id
      # @param [String] description the name this order will display
      # @param [Date] order_date
      # @param [Integer] lead_affiliate_id 0 should be used if none
      # @param [Integer] sale_affiliate_id 0 should be used if none
      # @return [Integer] returns the invoice id
      def invoice_create_blank_order(contact_id, description, order_date, lead_affiliate_id,
                                     sale_affiliate_id)
        response = get('InvoiceService.createBlankOrder', contact_id, description, order_date,
                        lead_affiliate_id, sale_affiliate_id)
      end

      # Adds a line item to an order. This used to add a Product to an order as well as
      # any other sort of charge/discount.
      #
      # @param [Integer] invoice_id
      # @param [Integer] product_id
      # @param [Integer] type  UNKNOWN = 0, SHIPPING = 1, TAX = 2, SERVICE = 3, PRODUCT = 4,
      #   UPSELL = 5, FINANCECHARGE = 6, SPECIAL = 7
      # @param [Float] price
      # @param [Integer] quantity
      # @param [String] description a full description of the line item
      # @param [String] notes
      # @return [Boolean] returns true/false if it was added successfully or not
      def invoice_add_order_item(invoice_id, product_id, type, price, quantity, description, notes)
        response = get('InvoiceService.addOrderItem', invoice_id, product_id, type, price,
                       quantity, description, notes)
      end

      # This will cause a credit card to be charged for the amount currently due on an invoice.
      #
      # @param [Integer] invoice_id
      # @param [String] notes a note about the payment
      # @param [Integer] credit_card_id
      # @param [Integer] merchant_account_id
      # @param [Boolean] bypass_commission
      # @return [Hash] containing the following keys {'Successful' => [Boolean],
      #   'Code' => [String], 'RefNum' => [String], 'Message' => [String]}
      def invoice_charge_invoice(invoice_id, notes, credit_card_id, merchant_account_id,
                                 bypass_commissions)
        response = get('InvoiceService.chargeInvoice', invoice_id, notes, credit_card_id,
                            merchant_account_id, bypass_commissions)
      end

      # Deletes the specified subscription from the database, as well as all invoices
      # tied to the subscription.
      #
      # @param [Integer] cprogram_id the id of the subscription being deleted
      # @return [Boolean]
      def invoice_delete_subscription(cprogram_id)
        response = get('InvoiceService.deleteSubscription', cprogram_id)
      end

      # Creates a subscription for a contact. Subscriptions are billing automatically
      # by infusionsoft within the next six hours. If you want to bill immediately you
      # will need to utilize the create_invoice_for_recurring and then
      # charge_invoice method to accomplish this.
      #
      # @param [Integer] contact_id
      # @param [Boolean] allow_duplicate
      # @param [Integer] cprogram_id the subscription id
      # @param [Integer] merchant_account_id
      # @param [Integer] credit_card_id
      # @param [Integer] affiliate_id
      # @param [Integer] days_till_charge number of days you want to wait till it's charged
      def invoice_add_recurring_order(contact_id, allow_duplicate, cprogram_id,
                                      merchant_account_id, credit_card_id, affiliate_id,
                                      days_till_charge)
        response = get('InvoiceService.addRecurringOrder', contact_id,
                       allow_duplicate, cprogram_id, merchant_account_id, credit_card_id,
                       affiliate_id, days_till_charge)
      end

      # This modifies the commissions being earned on a particular subscription.
      # This does not affect previously generated invoices for this subscription.
      #
      # @param [Integer] recurring_order_id
      # @param [Integer] affiliate_id
      # @param [Float] amount
      # @param [Integer] paryout_type how commissions will be earned (possible options are
      #   4 - up front earning, 5 - upon customer payment) typically this is 5
      # @return [Boolean]
      def invoice_add_recurring_commission_override(recurring_order_id, affiliate_id,
                                                    amount, payout_type, description)
        response = get('InvoiceService.addRecurringCommissionOverride', recurring_order_id,
                       affiliate_id, amount, payout_type, description)
      end

      # Adds a payment to an invoice without actually processing a charge through a merchant.
      #
      # @param [Integer] invoice_id
      # @param [Float] amount
      # @param [Date] date
      # @param [String] type Cash, Check, Credit Card, Money Order, PayPal, etc.
      # @param [String] description an area useful for noting payment details such as check number
      # @param [Boolean] bypass_commissions
      # @return [Boolean]
      def invoice_add_manual_payment(invoice_id, amount, date, type, description, bypass_commissions)
        response = get('InvoiceService.addManualPayment', invoice_id, amount, date, type,
                       description, bypass_commissions)
      end

      # This will create an invoice for all charges due on a Subscription. If the
      # subscription has three billing cycles that are due, it will create one
      # invoice with all three items attached.
      #
      # @param [Integer] recurring_order_id
      # @return [Integer] returns the id of the invoice that was created
      def invoice_create_invoice_for_recurring(recurring_order_id)
        response = get('InvoiceService.createInvoiceForRecurring', recurring_order_id)
      end

      # Adds a payment plan to an existing invoice.
      #
      # @param [Integer] invoice_id
      # @param [Boolean]
      # @param [Integer] credit_card_id
      # @param [Integer] merchant_account_id
      # @param [Integer] days_between_retry the number of days Infusionsoft should wait
      #   before re-attempting to charge a failed payment
      # @param [Integer] max_retry the maximum number of charge attempts
      # @param [Float] initial_payment_ammount the amount of the very first charge
      # @param [Date] initial_payment_date
      # @param [Date] plan_start_date
      # @param [Integer] number_of_payments the number of payments in this payplan (does not include
      #  initial payment)
      # @param [Integer] days_between_payments the number of days between each payment
      # @return [Boolean]
      def invoice_add_payment_plan(invoice_id, auto_charge, credit_card_id,
                                   merchant_account_id, days_between_retry, max_retry,
                                   initial_payment_amount, initial_payment_date, plan_start_date,
                                   number_of_payments, days_between_payments)
        response = get('InvoiceService.addPaymentPlan', invoice_id, auto_charge,
                       credit_card_id, merchant_account_id, days_between_retry, max_retry,
                       initial_payment_amount, initial_payment_date, plan_start_date, number_of_payments,
                       days_between_payments)
      end

      # Calculates the amount owed for a given invoice.
      #
      # @param [Integer] invoice_id
      # @return [Float]
      def invoice_calculate_amount_owed(invoice_id)
        response = get('InvoiceService.calculateAmountOwed', invoice_id)
      end

      # Retrieve all Payment Types currently setup under the Order Settings section of Infusionsoft.
      #
      # @return [Array]
      def invoice_get_all_payment_otpions
        response = get('InvoiceService.getAllPaymentOptions')
      end

      # Retrieves all payments for a given invoice.
      #
      # @param [Integer] invoice_id
      # @return [Array<Hash>] returns an array of payments
      def invoice_get_payments(invoice_id)
        response = get('Invoice.getPayments', invoice_id)
      end

      # Locates an existing card in the system for a contact, using the last 4 digits.
      #
      # @param [Integer] contact_id
      # @param [Integer] last_four
      # @return [Integer] returns the id of the credit card
      def invoice_locate_existing_card(contact_id, last_four)
        response = get('InvoiceService.locateExistingCard', contact_id, last_four)
      end

      # Calculates tax, and places it onto the given invoice.
      #
      # @param [Integer] invoice_id
      # @return [Boolean]
      def invoice_recalculate_tax(invoice_id)
        response = get('InvoiceService.recalculateTax', invoice_id)
      end

      # This will validate a credit card in the system.
      #
      # @param [Integer] credit_card_id if the card is already in the system
      # @return [Hash] returns a hash { 'Valid' => false, 'Message' => 'Card is expired' }
      def invoice_validate_card(credit_card_id)
        response = get('InvoiceService.validateCreditCard', credit_card_id)
      end

      # This will validate a credit card by passing in values of the
      # card directly (this card doesn't have to be added to the system).
      #
      # @param [Hash] data
      # @return [Hash] returns a hash { 'Valid' => false, 'Message' => 'Card is expired' }
      def invoice_validate_card(data)
        response = get('InvoiceService.validateCreditCard', data)
      end

      # Retrieves the shipping options currently setup for the Infusionsoft shopping cart.
      #
      # @return [Array]
      def invoice_get_all_shipping_options
        response = get('Invoice.getAllShippingOptions')
      end

      # Changes the next bill date on a subscription.
      #
      # @param [Integer] job_recurring_id this is the subscription id on the contact
      # @param [Date] next_bill_date
      # @return [Boolean]
      def invoice_update_recurring_next_bill_date(job_recurring_id, next_bill_date)
        response = get('InvoiceService.updateJobRecurringNextBillDate', job_recurring_id, next_bill_date)
      end


      # Adds a commission override to a one time order, using a combination of percentage
      # and hard-coded amounts.
      #
      # @param [Integer] invoice_id
      # @param [Integer] affiliate_id
      # @param [Integer] product_id
      # @param [Integer] percentage
      # @param [Float] amount
      # @param [Integer] payout_type how commision should be earned (4 - up front in full, 5 - upon
      #   customer payment
      # @param [String] description a note about this commission
      # @param [Date] date the commission was generated, not necessarily earned
      # @return [Boolean]
      def invoice_add_order_commission_override(invoice_id, affiliate_id, product_id, percentage,
                                                amount, payout_type, description, date)
        response = get('InvoiceService.addOrderCommissionOverride', invoice_id, affiliate_id,
                       product_id, percentage, amount, payout_type, description, date)
      end


      # Deprecated - Adds a recurring order to the database.
      def invoice_add_recurring_order_with_price(contact_id, allow_duplicate, cprogram_id, qty,
                                                 price, allow_tax, merchant_account_id,
                                                 credit_card_id, affiliate_id, days_till_charge)
        response = get('InvoiceService.addRecurringOrder', contact_id, allow_duplicate,
                       cprogram_id, qty, price, allow_tax, merchant_account_id, credit_card_id,
                       affiliate_id, days_till_charge)
      end

      # Deprecated - returns the invoice id from a one time order.
      def invoice_get_invoice_id(order_id)
        response = get('InvoiceService.getinvoice_id', order_id)
      end
    end
  end
end
