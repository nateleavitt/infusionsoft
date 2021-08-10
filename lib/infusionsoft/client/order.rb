module Infusionsoft
  class Client
    # The Order service allows you to create a new Order.
    module Order
      # Creates a new order.
      #
      # @param [Integer] contact_id
      #   ID of the order's Contact (0 is not a valid ID).
      # @param [Integer] card_id
      #   ID of the card to charge. To skip charging a card, set to "0".
      # @param [Integer] plan_id
      #   ID of the payment plan to use when creating the order. If not
      #   specified, the default plan is used.
      # @param [Array<Integer>] product_ids
      #   A list of integers representing the products to add to the order.
      #   This cannot be emtpy if a subscription is not specified.
      # @param [Array<Integer>] subscription_ids
      #   A list of integers representing the subscription(s) to add to the
      #   order. This cannot be empty if a product ID is not specified.
      # @param [Boolean] process_specials
      #   Whether or not the order should consider discounts that would normally
      #   be applied if this order was placed through the shopping cart.
      # @param [Array<String>] promo_codes
      #   Promo codes to add to the cart; only used if processing of specials
      #   is turned on.
      # @param [Integer] lead_affiliate_id
      #   ID of the lead affiliate (0 should be used if none).
      # @param [Integer] sale_affiliate_id
      #   ID of the sale affiliate (0 should be used if none).
      # @return [Hash] The result of order placement with IDs of the order and
      #   invoice that were created and the status of a credit card charge
      #   (if applicable).
      #   {'Successful' => [Boolean], 'Message' => [String], 'RefNum' => [String], 'OrderId' => [String], 'InvoiceId' => [String], 'Code' => [String]}
      def order_create_order(contact_id, card_id, plan_id, product_ids, subscription_ids, process_specials, promo_codes, lead_affiliate_id, sale_affiliate_id)
        response = xmlrpc('OrderService.placeOrder', contact_id, card_id, plan_id, product_ids, subscription_ids, process_specials, promo_codes, lead_affiliate_id, sale_affiliate_id)
      end
      alias_method :place_order, :order_create_order
    end
  end
end
