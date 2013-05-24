module Infusionsoft
  class Client
    # The Data service is used to manipulate most data in Infusionsoft. It permits you to
    # work on any available tables and has a wide range of uses.
    module Data
      # Adds a record with the data provided.
      #
      # @param [String] table the name of the Infusiosoft database table
      # @param [Hash] data the fields and it's data
      # @return [Integer] returns the id of the record added
      def data_add(table, data)
        response = get('DataService.add', table, data)
      end

      # This method will load a record from the database given the primary key.
      #
      # @param [String] table
      # @param [Integer] id
      # @param [Array] selected_fields
      # @return [Hash] the field names and their data
      # @example
      #   { "FirstName" => "John", "LastName" => "Doe" }
      def data_load(table, id, selected_fields)
        response = get('DataService.load', table, id, selected_fields)
      end

      # Updates the specified record (indicated by ID) with the data provided.
      #
      # @param [String] table
      # @param [Integer] id
      # @param [Hash] data this is the fields and values you would like to update
      # @return [Integer] id of the record updated
      # @example
      #   { :FirstName => 'John', :Email => 'test@test.com' }
      def data_update(table, id, data)
        response = get('DataService.update', table, id, data)
      end

      # Deletes the record (specified by id) in the given table from the database.
      #
      # @param [String] table
      # @param [Integer] id
      # @return [Boolean] returns true/false if the record was successfully deleted
      def data_delete(table, id)
        response = get('DataService.delete', table, id)
      end

      # This will locate all records in a given table that match the criteria for a given field.
      #
      # @param [String] table
      # @param [Integer] limit how many records you would like to return (max is 1000)
      # @param [Integer] page the page of results (each page is max 1000 records)
      # @param [String] field_name
      # @param [String, Integer, Date] field_value
      # @param [Array] selected_fields
      # @return [Array<Hash>] returns the array of records with a hash of the fields and values
      def data_find_by_field(table, limit, page, field_name, field_value, selected_fields)
        response = get('DataService.findByField', table, limit, page, field_name,
                       field_value, selected_fields)
      end

      # Queries records in a given table to find matches on certain fields.
      #
      # @param [String] table
      # @param [Integer] limit
      # @param [Integer] page
      # @param [Hash] data  the data you would like to query on. { :FirstName => 'first_name' }
      # @param [Array] selected_fields the fields and values you want back
      # @return [Array<Hash>] the fields and associated values
      def data_query(table, limit, page, data, selected_fields)
        response = get('DataService.query', table, limit, page, data, selected_fields)
      end

      # Queries records in a given table to find matches on certain fields.
      #
      # @param [String] table
      # @param [Integer] limit
      # @param [Integer] page
      # @param [Hash] data  the data you would like to query on. { :FirstName => 'first_name' }
      # @param [Array] selected_fields the fields and values you want back
      # @param [String] field by which to order the output results
      # @param [Boolean] true ascending, false descending
      # @return [Array<Hash>] the fields and associated values
      def data_query_order_by(table, limit, page, data, selected_fields, by, ascending)
        response = get('DataService.query', table, limit, page, data, selected_fields, by, ascending)
      end

      # Adds a custom field to Infusionsoft
      #
      # @param [String] field_type options include Person, Company, Affiliate, Task/Appt/Note,
      #   Order, Subscription, or Opportunity
      # @param [String] name
      # @param [String] data_type the type of field Text, Dropdown, TextArea
      # @param [Integer] header_id see notes here
      #   http://help.infusionsoft.com/developers/services-methods/data/addCustomField
      def data_add_custom_field(field_type, name, data_type, header_id)
        response = get('DataService.addCustomField', field_type, name, data_type, header_id)
      end

      # Authenticate an Infusionsoft username and password(md5 hash). If the credentials match
      # it will return back a User ID, if the credentials do not match it will send back an
      # error message
      #
      # @param [String] username
      # @param [String] password
      # @return [Integer] id of the authenticated user
      def data_authenticate_user(username, password)
        response = get('DataService.authenticateUser', username, password)
      end

      # This method will return back the data currently configured in a user configured
      # application setting.
      #
      # @param [String] module
      # @param [String] setting
      # @return [String] current values in given application setting
      # @note to find the module and option names, view the HTML field name within the Infusionsoft
      #   settings. You will see something such as name="Contact_WebModule0optiontypes" . The portion
      #   before the underscore is the module name. "Contact" in this example. The portion after the
      #   0 is the setting name, "optiontypes" in this example.
      def data_get_app_setting(module_name, setting)
        response = get('DataService.getAppSetting', module_name, setting)
      end

      # Returns a temporary API key if given a valid Vendor key and user credentials.
      #
      # @param [String] vendor_key
      # @param [String] username
      # @param [String] password_hash an md5 hash of users password
      # @return [String] temporary API key
      def data_get_temporary_key(vendor_key, username, password_hash)
        response = get('DataService.getTemporaryKey', username, password_hash)
      end

      # Updates a custom field. Every field can have it’s display name and group id changed,
      # but only certain data types will allow you to change values(dropdown, listbox, radio, etc).
      #
      # @param [Integer] field_id
      # @param [Hash] field_values
      # @return [Boolean] returns true/false if it was updated
      def data_update_custom_field(field_id, field_values)
        response = get('DataService.updateCustomField', field_id, field_values)
      end
    end
  end
end
