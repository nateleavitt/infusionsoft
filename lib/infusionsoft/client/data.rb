module Infusionsoft
  class Client
    ########################
    ###   Data Service   ###
    ########################
    module Data
      # Adds a record to the database. If you attempt to set fields that are marked read-only
      # by the Data Spec, this operation will simply ignore those fields - not throw an error
      #
      # @table [String]
      # @values [Hash]
      def data_add(table, values)
        response = get('DataService.add', table, values)
      end

      # This will locate all records in a given table that match the criteria for a given field.
      #
      # @table [String]
      # @limit [Integer]
      # @page [Integer]
      # @field_name [String]
      # @field_value [String]
      # @selected_fields [Array]
      def data_find_by_field(table, limit, page, field_name, field_value, selected_fields)
        response = get('DataService.findByField', table, limit, page, field_name,
                       field_value, selected_fields)
      end

      # This method will load a record from the database given the primary key
      #
      # @table [String]
      # @id [Integer]
      # @selected_fields [Array]
      def data_load(table, id, selected_fields)
        response = get('DataService.load', table, id, selected_fields)
      end

      # Queries records in a given table to find matches on certain fields
      #
      # @table [String]
      # @limit [Integer]
      # @page [Integer]
      # @data [Hash] The data you would like to query on. { :FirstName => 'first_name' }
      # @selected_fields [Array]
      def data_query(table, limit, page, data, selected_fields)
        response = get('DataService.query', table, limit, page, data, selected_fields)
      end

      # Updates a given record to the database
      #
      # @table [String]
      # @id [Integer]
      # @values [Hash] This is the fields and values you would like to update
      # @example { :FirstName => 'first_name', :EmailAddress1 => 'test@test.com' }
      def data_update(table, id, values)
        response = get('DataService.update', table, id, values)
      end

      # Adds a custom field to Infusionsoft
      #
      # @context [String]
      # @label [String]
      # @data_type [String]
      # @group_id [Integer]
      def data_add_custom_field(context, label, data_type, group_id)
        response = get('DataService.addCustomField', context, label, data_type, group_id)
      end

      # Updates a custom field
      #
      # @field_id [Integer]
      # @field_value
      def data_update_custom_field(field_id, field_value)
        response = get('DataService.updateCustomField', field_id, field_value)
      end

      # Authenticates a user account in Infusionsoft
      #
      # @username [String]
      # @password [String]
      def data_authenticate_user(username, password)
        response = get('DataService.authenticateUser', username, password)
      end

      def data_echo(text)
        response = get('DataService.echo', text)
      end
    end
  end
end
