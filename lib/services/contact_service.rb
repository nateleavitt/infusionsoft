module ContactService
  ########################  
  ### Contact Service  ###
  ########################

  def api_contact_find_by_email(email, selected_fields)
    # Finds all contacts with the supplied email address in any of the three contact record email addresses
    Thread.current[:api_conn].api_perform('ContactService', 'findByEmail', email, selected_fields)
  end

  def api_contact_add(data)
    # Adds a contact to the database
    @contact_id = Thread.current[:api_conn].api_perform('ContactService', 'add', data)
    # Checks to see if email exists
    if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
    return @contact_id
  end

  def api_contact_add_recurring_order(contact_id, allow_duplicate, cprogram_id, merchant_account_id, credit_card_id, affiliate_id,
                        days_till_charge)
    # Creates a new recurring order for a contact.
    Thread.current[:api_conn].api_perform('ContactService','addRecurringOrder', contact_id, allow_duplicate, cprogram_id, 
                        merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
  end

  def api_contact_add_to_group(contact_id, group_id)
    # Adds a contact to a group
    Thread.current[:api_conn].api_perform('ContactService', 'addToGroup', contact_id, group_id)
  end

  def api_contact_link_contact(remoteApp, remoteId, localId)
    Thread.current[:api_conn].api_perform('ContactService', 'linkContact', remoteApp, remoteId, localId)
  end

  def api_contact_load(id, selected_fields)
    # Loads a contact from the database
    Thread.current[:api_conn].api_perform('ContactService', 'load', id, selected_fields)
  end

  def api_contact_locate_contact_link(locate_map_id)
    Thread.current[:api_conn].api_perform('ContactService', 'locateContactLink', locate_map_id)
  end

  def api_contact_mark_link_updated(locate_map_id)
    Thread.current[:api_conn].api_perform('ContactService', 'markLinkUpdated', locate_map_id)
  end

  def api_contact_add_to_campaign(contact_id, campaign_id)
    # Adds a contact to a campaign.
    Thread.current[:api_conn].api_perform('ContactService','addToCampaign', contact_id, campaign_id)
  end

  def api_contact_pause_campaign(contact_id, campaign_id)
    # Pauses a campaign for a given contact.
    Thread.current[:api_conn].api_perform('ContactService', 'pauseCampaign', contact_id, campaign_id)
  end

  def api_contact_remove_from_campaign(contact_id, campaign_id)
    # Removes a contact from a given campaign.
    Thread.current[:api_conn].api_perform('ContactService', 'removeFromCampaign', contact_id, campaign_id)
  end

  def api_contact_get_next_campaign_step(contact_id, campaign_id)
    # returns the next step in a campaign
    Thread.current[:api_conn].api_perform('ContactService', 'getNextCampaignStep', contact_id, campaign_id)
  end

  def api_contact_reschedule_campaign_step(list_of_contacts, campaign_id)
    # Reschedules a campaign step for a list of contacts
    Thread.current[:api_conn].api_perform('ContactService', 'reschedulteCampaignStep', list_of_contacts, campaign_id)
  end

  def api_contact_remove_from_group(contact_id, group_id)
    # Removes a contact from a given group.
    Thread.current[:api_conn].api_perform('ContactService', 'removeFromGroup', contact_id, group_id)
  end

  def api_contact_run_action_set(contact_id, action_set_id)
    # Executes an action sequence for a given contact
    Thread.current[:api_conn].api_perform('ContactService', 'runActionSequence', contact_id, action_set_id)
  end

  def api_contact_run_action_set_with_params(contact_id, action_set_id, params)
    # Executes an action sequence for a given contact, passing in
    # runtime params for running affiliate signup actions, etc
    Thread.current[:api_conn].api_perform('ContactService', 'runActionSequence', contact_id, action_set_id, params)
  end

  def api_contact_update(contact_id, data)
    # Updates a contact in the database.
    @bool = Thread.current[:api_conn].api_perform('ContactService', 'update', contact_id, data)
    if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
    return @bool
  end
end
