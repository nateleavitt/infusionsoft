module ApiInfusionsoft
  class Client
    ########################  
    ### Contact Service  ###
    ########################
    module Contact
      # Finds all contacts with the supplied email address in any of the three contact record email addresses
      def api_contact_find_by_email(email, selected_fields)
        response = get('ContactService.findByEmail', email, selected_fields)
      end

      # Adds a contact to the database
      # Checks to see if email exists
      def api_contact_add(data)
        contact_id = get('ContactService.add', data)
        if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
        return contact_id
      end

      # Creates a new recurring order for a contact.
      def api_contact_add_recurring_order(contact_id, allow_duplicate, cprogram_id, merchant_account_id, credit_card_id, affiliate_id,
                            days_till_charge)
        response = get('ContactService','addRecurringOrder', contact_id, allow_duplicate, cprogram_id, 
                            merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
      end

      # Adds a contact to a group
      def api_contact_add_to_group(contact_id, group_id)
        response = get('ContactService', 'addToGroup', contact_id, group_id)
      end

      def api_contact_link_contact(remoteApp, remoteId, localId)
        response = get('ContactService', 'linkContact', remoteApp, remoteId, localId)
      end

      # Loads a contact from the database
      def api_contact_load(id, selected_fields)
        response = get('ContactService', 'load', id, selected_fields)
      end

      def api_contact_locate_contact_link(locate_map_id)
        response = get('ContactService', 'locateContactLink', locate_map_id)
      end

      def api_contact_mark_link_updated(locate_map_id)
        response = get('ContactService', 'markLinkUpdated', locate_map_id)
      end

      # Adds a contact to a campaign.
      def api_contact_add_to_campaign(contact_id, campaign_id)
        response = get('ContactService','addToCampaign', contact_id, campaign_id)
      end

      # Pauses a campaign for a given contact.
      def api_contact_pause_campaign(contact_id, campaign_id)
        response = get('ContactService', 'pauseCampaign', contact_id, campaign_id)
      end

      # Removes a contact from a given campaign.
      def api_contact_remove_from_campaign(contact_id, campaign_id)
        response = get('ContactService', 'removeFromCampaign', contact_id, campaign_id)
      end

      # returns the next step in a campaign
      def api_contact_get_next_campaign_step(contact_id, campaign_id)
        response = get('ContactService', 'getNextCampaignStep', contact_id, campaign_id)
      end

      # Reschedules a campaign step for a list of contacts
      def api_contact_reschedule_campaign_step(list_of_contacts, campaign_id)
        response = get('ContactService', 'reschedulteCampaignStep', list_of_contacts, campaign_id)
      end

      # Removes a contact from a given group.
      def api_contact_remove_from_group(contact_id, group_id)
        response = get('ContactService', 'removeFromGroup', contact_id, group_id)
      end

      # Executes an action sequence for a given contact
      def api_contact_run_action_set(contact_id, action_set_id)
        response = get('ContactService', 'runActionSequence', contact_id, action_set_id)
      end

      # Executes an action sequence for a given contact, passing in
      # runtime params for running affiliate signup actions, etc
      def api_contact_run_action_set_with_params(contact_id, action_set_id, params)
        response = get('ContactService', 'runActionSequence', contact_id, action_set_id, params)
      end

      # Updates a contact in the database.
      def api_contact_update(contact_id, data)
        bool = get('ContactService', 'update', contact_id, data)
        if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
        return bool
      end
    end
  end
end
