module Infusionsoft
  class Client
    # Contact service is used to manage contacts. You can add, update and find contacts in
    # addition to managing follow up sequences, tags and action sets.
    module Contact
      # Creates a new contact record from the data passed in the associative array.
      #
      # @param [Hash] data contains the mappable contact fields and it's data
      # @return [Integer] the id of the newly added contact
      # @example
      #   { :Email => 'test@test.com', :FirstName => 'first_name', :LastName => 'last_name' }
      def contact_add(data)
        contact_id = get('ContactService.add', data)
        if data.has_key?(:Email); email_optin(data[:Email], "requested information"); end
        return contact_id
      end
      
      # Merge two contacts together.
      #
      # @param [Integer] contact_id
      # @param [Integer] duplicate_contact_id
      def contact_merge(contact_id, duplicate_contact_id)
        response = get('ContactService.merge', contact_id, duplicate_contact_id)
      end

      # Adds or updates a contact record based on matching data
      #
      # @param [Array<Hash>] data the contact data you want added
      # @param [String] check_type available options are 'Email', 'EmailAndName',
      #   'EmailAndNameAndCompany'
      # @return [Integer] id of the contact added or updated
      def contact_add_with_dup_check(data, check_type)
        contact_id = get('ContactService.addWithDupCheck', data, check_type)
        if data.has_key?(:Email); email_optin(data[:Email], "requested information"); end
        return contact_id
      end

      # Updates a contact in the database.
      #
      # @param [Integer] contact_id
      # @param [Hash] data contains the mappable contact fields and it's data
      # @return [Integer] the id of the contact updated
      # @example
      #   { :FirstName => 'first_name', :StreetAddress1 => '123 N Street' }
      def contact_update(contact_id, data)
        contact_id = get('ContactService.update', contact_id, data)
        if data.has_key?(:Email); email_optin(data[:Email], "requested information"); end
        return contact_id
      end

      # Loads a contact from the database
      #
      # @param [Integer] id
      # @param [Array] selected_fields the list of fields you want back
      # @return [Array] the fields returned back with it's data
      # @example this is what you would get back
      #   { "FirstName" => "John", "LastName" => "Doe" }
      def contact_load(id, selected_fields)
        response = get('ContactService.load', id, selected_fields)
      end

      # Finds all contacts with the supplied email address in any of the three contact record email
      # addresses.
      #
      # @param [String] email
      # @param [Array] selected_fields the list of fields you want with it's data
      # @return [Array<Hash>] the list of contacts with it's fields and data
      def contact_find_by_email(email, selected_fields)
        response = get('ContactService.findByEmail', email, selected_fields)
      end

      # Adds a contact to a follow-up sequence (campaigns were the original name of follow-up sequences).
      #
      # @param [Integer] contact_id
      # @param [Integer] campaign_id
      # @return [Boolean] returns true/false if the contact was added to the follow-up sequence
      #   successfully
      def contact_add_to_campaign(contact_id, campaign_id)
        response = get('ContactService.addToCampaign', contact_id, campaign_id)
      end

      # Returns the Id number of the next follow-up sequence step for the given contact.
      #
      # @param [Integer] contact_id
      # @param [Integer] campaign_id
      # @return [Integer] id number of the next unfishished step in the given follow up sequence
      #   for the given contact
      def contact_get_next_campaign_step(contact_id, campaign_id)
        response = get('ContactService.getNextCampaignStep', contact_id, campaign_id)
      end

      # Pauses a follow-up sequence for the given contact record
      #
      # @param [Integer] contact_id
      # @param [Integer] campaign_id
      # @return [Boolean] returns true/false if the sequence was paused
      def contact_pause_campaign(contact_id, campaign_id)
        response = get('ContactService.pauseCampaign', contact_id, campaign_id)
      end

      # Removes a follow-up sequence from a contact record
      #
      # @param [Integer] contact_id
      # @param [Integer] campaign_id
      # @return [Boolean] returns true/false if removed
      def contact_remove_from_campaign(contact_id, campaign_id)
        response = get('ContactService.removeFromCampaign', contact_id, campaign_id)
      end

      # Resumes a follow-up sequence that has been stopped/paused for a given contact.
      #
      # @param [Integer] contact_id
      # @param [Ingeger] campaign_id
      # @return [Boolean] returns true/false if sequence was resumed
      def contact_resume_campaign(contact_id, campaign_id)
        response = get('ConactService.resumeCampaignForContact', contact_id, campaign_id)
      end

      # Immediately performs the given follow-up sequence step_id for the given contacts.
      #
      # @param [Array<Integer>] list_of_contacts
      # @param [Integer] ) step_id
      # @return [Boolean] returns true/false if the step was rescheduled
      def contact_reschedule_campaign_step(list_of_contacts, step_id)
        response = get('ContactService.reschedulteCampaignStep', list_of_contacts, step_id)
      end

      # Removes a tag from a contact (groups were the original name of tags).
      #
      # @param [Integer] contact_id
      # @param [Integer] group_id
      # @return [Boolean] returns true/false if tag was removed successfully
      def contact_remove_from_group(contact_id, group_id)
        response = get('ContactService.removeFromGroup', contact_id, group_id)
      end

      # Adds a tag to a contact
      #
      # @param [Integer] contact_id
      # @param [Integer] group_id
      # @return [Boolean] returns true/false if the tag was added successfully
      def contact_add_to_group(contact_id, group_id)
        response = get('ContactService.addToGroup', contact_id, group_id)
      end

      # Runs an action set on a given contact record
      #
      # @param [Integer] contact_id
      # @param [Integer] action_set_id
      # @return [Array<Hash>] A list of details on each action run
      # @example here is a list of what you get back
      #   [{ 'Action' => 'Create Task', 'Message' => 'task1 (Task) sent successfully', 'isError' =>
      #   nil }]
      def contact_run_action_set(contact_id, action_set_id)
        response = get('ContactService.runActionSequence', contact_id, action_set_id)
      end

      def contact_link_contact(remoteApp, remoteId, localId)
        response = get('ContactService.linkContact', remoteApp, remoteId, localId)
      end


      def contact_locate_contact_link(locate_map_id)
        response = get('ContactService.locateContactLink', locate_map_id)
      end

      def contact_mark_link_updated(locate_map_id)
        response = get('ContactService.markLinkUpdated', locate_map_id)
      end

      # Creates a new recurring order for a contact.
      #
      # @param [Integer] contact_id
      # @param [Boolean] allow_duplicate
      # @param [Integer] cprogram_id
      # @param [Integer] merchant_account_id
      # @param [Integer] credit_card_id
      # @param [Integer] affiliate_id
      def contact_add_recurring_order(contact_id, allow_duplicate, cprogram_id, merchant_account_id,
                                      credit_card_id, affiliate_id, days_till_charge)
        response = get('ContactService.addRecurringOrder', contact_id, allow_duplicate, cprogram_id,
                            merchant_account_id, credit_card_id, affiliate_id, days_till_charge)
      end

      # Executes an action sequence for a given contact, passing in runtime params
      # for running affiliate signup actions, etc
      #
      # @param [Integer] contact_id
      # @param [Integer] action_set_id
      # @param [Hash] data
      def contact_run_action_set_with_params(contact_id, action_set_id, data)
        response = get('ContactService.runActionSequence', contact_id, action_set_id, data)
      end

    end
  end
end
