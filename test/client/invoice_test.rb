require_relative('../test_helper')

class InvoiceTest < Test::Unit::TestCase


  def test_invoice_add_recurring_order
    VCR.use_cassette('invoice_add_recurring_order') do
      result = Infusionsoft.invoice_add_recurring_order(1, true, 1, 1, 10.0, true, 1, 1, 0, 0)

      assert_instance_of Fixnum, result
    end
  end

end
