module ApiInfusionsoft

  module Connection
    private

    def connection(service_call, method, *args)
      server = XMLRPC::Client.new3({'host' => api_url, 'path' => "/api/xmlrpc", 'port' => 443, 'use_ssl' => true})
      result = server.call("#{service_call}", api_key, *params)
      return result
    end

    #end
        #if result.nil?; raise RetryException.new(true, @retry_count), "transient read error" end
      #rescue RetryException => detail
        ## Catch for transietn Infusionsoft connection errors
        #puts "*** INFUSION API ERROR: Transient read error *** retrying: #{@retry_count}"
        #self.retry_count += 1
        #retry if detail.ok_to_retry
      #rescue XMLRPC::FaultException => e
        #puts "*** INFUSION API ERROR: #{e.faultCode} - #{e.faultString} ***"
      #rescue Timeout::Error
        #detail = RetryException.new(true, @retry_count)
        #puts "*** INFUSION API ERROR: Timeout *** retrying #{@retry_count}"
        #@retry_count += 1
        #retry if detail.ok_to_retry
      #rescue
        #detail = RetryException.new(true, @retry_count)
        ## This is most likely a catch for the infamous Content-Type bug from Infusionsoft.
        ## Their response has an issue where it isn't sending back a Content-Type in the header,
        ## which throws an nill error in the xml-rpc client in Ruby.
        ## see xmlrcp/client.rb:552 and xmlrpc/utils.rb:159 in Ruby Standard Library.
        #puts "*** INFUSION API ERROR: Content Type is nil back from Infusionsoft *** retrying: #{@retry_count}"
        #@retry_count += 1
        #retry if detail.ok_to_retry
      #end

  end
end
