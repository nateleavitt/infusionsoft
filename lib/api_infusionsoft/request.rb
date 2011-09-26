module ApiInfusionsoft
  module Request
    # Perform an GET request
    def get(service_call, *args)
      puts "Request::get **** #{service_call}, #{args.inspect}"
      request(:get, service_call, *args)
    end

    def post(path, params={}, options={})
      request(:post, path, params, options)
    end

    # Perform an HTTP PUT request
    def put(path, params={}, options={})
      request(:put, path, params, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, params={}, options={})
      request(:delete, path, params, options)
    end


    private

    # Perform request
    def request(method, service_call, *args)
      case method.to_sym
      when :get
        puts "Request::request **** #{method}, #{service_call}, #{args.inspect}"
        response = connection(service_call, *args)
      end
    end
  end
end
