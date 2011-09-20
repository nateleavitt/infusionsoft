require "xmlrpc/client"

class InfusionsoftApiConnection
  attr_accessor :api_url, :api_key, :retry_count

  def initialize(url, key)
    @api_url = url
    @api_key = key
    @retry_count = 1
  end

  def api_perform(class_type, method, *args)
   begin
      server = XMLRPC::Client.new3({'host' => @api_url, 'path' => "/api/xmlrpc", 'port' => 443, 'use_ssl' => true})
      result = server.call("#{class_type}.#{method}", @api_key, *args)
      if result.nil?; raise RetryException.new(true, @retry_count), "transient read error" end
    rescue RetryException => detail
      # Catch for transietn Infusionsoft connection errors
      puts "*** INFUSION API ERROR: Transient read error *** retrying: #{@retry_count}"
      self.retry_count += 1
      retry if detail.ok_to_retry
    rescue XMLRPC::FaultException => e
      puts "*** INFUSION API ERROR: #{e.faultCode} - #{e.faultString} ***"
    rescue Timeout::Error
      detail = RetryException.new(true, @retry_count)
      puts "*** INFUSION API ERROR: Timeout *** retrying #{@retry_count}"
      @retry_count += 1
      retry if detail.ok_to_retry
    rescue
      detail = RetryException.new(true, @retry_count)
      # This is most likely a catch for the infamous Content-Type bug from Infusionsoft.
      # Their response has an issue where it isn't sending back a Content-Type in the header,
      # which throws an nill error in the xml-rpc client in Ruby.
      # see xmlrcp/client.rb:552 and xmlrpc/utils.rb:159 in Ruby Standard Library.
      puts "*** INFUSION API ERROR: Content Type is nil back from Infusionsoft *** retrying: #{@retry_count}"
      @retry_count += 1
      retry if detail.ok_to_retry
    end

    return result
  end

end

class RetryException < RuntimeError
  attr :ok_to_retry
  def initialize(ok_to_retry, retry_count)
    @ok_to_retry = retry_count < 5 ? ok_to_retry : false
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


 include 'services/ContactService'
 include 'services/EmailService'
 include 'services/DataService'
 include 'services/InvoiceService'
 include 'services/AffiliateService'
 include 'services/TicketService'
 include 'services/FileService'

end
