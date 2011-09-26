module Infusionsoft
  class Client
    ########################  
    ### Contact Service  ###
    ########################
    module Contact
      # Finds all contacts with the supplied email address in any of the three contact record email addresses
      #
      # @email [String]
      # @selected_fields [Array]
      def contact_find_by_email(email, selected_fields)
        response = get('ContactService.findByEmail', email, selected_fields)
      end

      # Adds a contact to the database, then opts in the email address
      #
      # @data = [Hash]
      # @example data = {:EmailAddress1 => 'test@test.com', :FirstName => 'first_name', :LastName => 'last_name'}
      # @returns [Integer] This is the id of the newly added contact
      def contact_add(data)
        contact_id = get('ContactService.add', data)
        if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
        return contact_id
      end

      # Creates a new recurring order for a contact.
      #
      # @contact_id [Integer]
      # @allow_duplicate [Boolean]
      # @cprogram_id [Integer]
      # @merchante_account_id [Integer]
      # @credit_card_id [Integer]
      # @affiliate_id [Integer]
      def contact_add_recurring_order(contact_id, allow_duplicate, cprogram_id, merchant_account_id, credit_card_id, affiliate_id,
                            days_till_charge)
        response = get('ContactService','addRecurringOrder', contact_id, allow_duplicate, cprogram_id, 
                            merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
      end

      # Adds a contact to a group
      #
      # @contact_id [Integer]
      # @group_id [Integer]
      def contact_add_to_group(contact_id, group_id)
        response = get('ContactService', 'addToGroup', contact_id, group_id)
      end

      def contact_link_contact(remoteApp, remoteId, localId)
        response = get('ContactService', 'linkContact', remoteApp, remoteId, localId)
      end

      # Loads a contact from the database
      #
      # @id [Integer]
      # @selected_fields [Array]
      def contact_load(id, selected_fields)
        response = get('ContactService', 'load', id, selected_fields)
      end

      def contact_locate_contact_link(locate_map_id)
        response = get('ContactService', 'locateContactLink', locate_map_id)
      end

      def contact_mark_link_updated(locate_map_id)
        response = get('ContactService', 'markLinkUpdated', locate_map_id)
      end

      # Adds a contact to a campaign.
      #
      # @contact_id [Integer]
      # @campaign_id [Integer]
      def contact_add_to_campaign(contact_id, campaign_id)
        response = get('ContactService','addToCampaign', contact_id, campaign_id)
      end

      # Pauses a campaign for a given contact.
      #
      # @contact_id [Integer]
      # @campaign_id [Integer]
      def contact_pause_campaign(contact_id, campaign_id)
        response = get('ContactService', 'pauseCampaign', contact_id, campaign_id)
      end

      # Removes a contact from a given campaign.
      #
      # @contact_id [Integer]
      # @campaign_id [Integer]
      def contact_remove_from_campaign(contact_id, campaign_id)
        response = get('ContactService', 'removeFromCampaign', contact_id, campaign_id)
      end

      # returns the next step in a campaign
      #
      # @contact_id [Integer]
      # @campaign_id [Integer]
      def contact_get_next_campaign_step(contact_id, campaign_id)
        response = get('ContactService', 'getNextCampaignStep', contact_id, campaign_id)
      end

      # Reschedules a campaign step for a list of contacts
      #
      # @list_of_contacts [Array]
      # @campaign_id [Integer]
      def contact_reschedule_campaign_step(list_of_contacts, campaign_id)
        response = get('ContactService', 'reschedulteCampaignStep', list_of_contacts, campaign_id)
      end

      # Removes a contact from a given group.
      #
      # @contact_id [Integer]
      # @group_id [Integer]
      def contact_remove_from_group(contact_id, group_id)
        response = get('ContactService', 'removeFromGroup', contact_id, group_id)
      end

      # Executes an action sequence for a given contact
      def contact_run_action_set(contact_id, action_set_id)
        response = get('ContactService', 'runActionSequence', contact_id, action_set_id)
      end

      # Executes an action sequence for a given contact, passing in
      # runtime params for running affiliate signup actions, etc
      #
      # @contact_id [Integer]
      # @action_set_id [Integer]
      # @params [Hash]
      def contact_run_action_set_with_params(contact_id, action_set_id, params)
        response = get('ContactService', 'runActionSequence', contact_id, action_set_id, params)
      end

      # Updates a contact in the database.
      #
      # @contact_id [Integer]
      # @data [Hash]
      # @example {:FirstName => 'first_name', :StreetAddress1 => '123 N Street'}
      def contact_update(contact_id, data)
        bool = get('ContactService', 'update', contact_id, data)
        if data.has_key?("Email"); api_email_optin(data["Email"], "requested information"); end
        return bool
      end
    end
  end
end
