module DataService
  ########################  
  ###   Data Service   ###
  ########################

  def api_data_add(table, values)
    # Adds a record to the database
    # If you attempt to set fields that are marked read-only by the
    # Data Spec, this operation will simply ignore those fields - not
    # throw an error
    Thread.current[:api_conn].api_perform('DataService', 'add', table, values)
  end

  def api_data_find_by_field(table, limit, page, field_name, field_value, selected_fields)
    # This will locate all records in a given table that match the
    # criteria for a given field.
    Thread.current[:api_conn].api_perform('DataService', 'findByField', table, limit, page, field_name,
                        field_value, selected_fields)
  end

  def api_data_load(table, id, selected_fields)
    # This method will load a record from the database given the
    # primary key
    Thread.current[:api_conn].api_perform('DataService', 'load', table, id, selected_fields)
  end

  def api_data_query(table, limit, page, queryData, selected_fields)
    # Queries records in a given table to find matches on certain
    # fields
    Thread.current[:api_conn].api_perform('DataService', 'query', table, limit, page, queryData, selected_fields)
  end

  def api_data_update(table, id, values)
    # Updates a given record to the database
    Thread.current[:api_conn].api_perform('DataService', 'update', table, id, values)
  end

  def api_data_add_custom_field(context, label, data_type, group_id)
    # Adds a custom field to Infusionsoft
    Thread.current[:api_conn].api_perform('DataService', 'addCustomField', context, label, data_type, group_id)
  end

  def api_data_update_custom_field(field_id, field_value)
    # Updates a custom field
    Thread.current[:api_conn].api_perform('DataService', 'updateCustomField', field_id, field_value)
  end

  def api_data_authenticate_user(username, password)
    # Authenticates a user account in Infusionsoft
    Thread.current[:api_conn].api_perform('DataService', 'authenticateUser', username, password)
  end

  def api_data_echo(text)
    Thread.current[:api_conn].api_perform('DataService', 'echo', text)
  end
end
