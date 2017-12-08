require_relative('../test_helper')

class InvoiceTest < Test::Unit::TestCase

  def test_invoice_add_recurring_order
    VCR.use_cassette('invoice_add_recurring_order') do
      result = Infusionsoft.invoice_add_recurring_order(4095, true, 19, 4, 9957, 0, 0)

      assert_instance_of Fixnum, result
    end
  end

  def test_invoice_add_subscription
    VCR.use_cassette('invoice_add_subscription') do
      result = Infusionsoft.invoice_add_subscription(4095, true, 19, 1, 27.0, false, 4, 9957, 0, 0)

      assert_instance_of Fixnum, result
    end
  end

  def test_add_manual_payment
    VCR.use_cassette('invoice_add_manual_payment') do
      result = Infusionsoft.invoice_add_manual_payment(60, 199.00, Time.now, 'Credit Card', 'Paid in full', false)

      assert_instance_of TrueClass, result
    end
  end




end
