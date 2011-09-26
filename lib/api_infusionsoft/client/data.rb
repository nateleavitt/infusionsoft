module ApiInfusionsoft
  class Client
    ########################  
    ###   Data Service   ###
    ########################
    module Data
      # Adds a record to the database. If you attempt to set fields that are marked read-only 
      # by the Data Spec, this operation will simply ignore those fields - not throw an error
      #
      # @table String
      # @values Hash
      def data_add(table, values)
        response = get('DataService.add', table, values)
      end

      def data_find_by_field(table, limit, page, field_name, field_value, selected_fields)
        # This will locate all records in a given table that match the criteria for a given field.
        response = get('DataService.findByField', table, limit, page, field_name,
                       field_value, selected_fields)
      end

      def data_load(table, id, selected_fields)
        # This method will load a record from the database given the primary key
        puts "module::Data **** #{table}, #{id}, #{selected_fields.inspect} ***"
        response = get('DataService.load', table, id, selected_fields)
      end

      def data_query(table, limit, page, queryData, selected_fields)
        # Queries records in a given table to find matches on certain fields
        response = get('DataService.query', table, limit, page, queryData, selected_fields)
      end

      def data_update(table, id, values)
        # Updates a given record to the database
        response = get('DataService.update', table, id, values)
      end

      def data_add_custom_field(context, label, data_type, group_id)
        # Adds a custom field to Infusionsoft
        response = get('DataService.addCustomField', context, label, data_type, group_id)
      end

      def data_update_custom_field(field_id, field_value)
        # Updates a custom field
        response = get('DataService.updateCustomField', field_id, field_value)
      end

      def data_authenticate_user(username, password)
        # Authenticates a user account in Infusionsoft
        response = get('DataService.authenticateUser', username, password)
      end

      def data_echo(text)
        response = get('DataService.echo', text)
      end
    end
  end
end
