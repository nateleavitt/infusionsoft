module Infusionsoft
  class Client
    # The Email service allows you to email your contacts as well as attaching emails sent
    # elsewhere (this lets you send email from multiple services and still see all communications
    # inside of Infusionsoft).
    module Email

      # Create a new email template that can be used for future emails
      #
      # @param [String] title
      # @param [String] categories a comma separated list of the categories
      #   you want this template in Infusionsoft
      # @param [String] from the from address format use is 'FirstName LastName <email@domain.com>'
      # @param [String] to the email address this template is sent to
      # @param [String] cc a comma separated list of cc email addresses
      # @param [String] bcc a comma separated list of bcc email addresses
      # @param [String] subject
      # @param [String] text_body
      # @param [String] html_body
      # @param [String] content_type can be Text, HTML, Multipart
      # @param [String] merge_context can be Contact, ServiceCall, Opportunity, CreditCard
      def email_add(title, categories, from, to, cc, bcc, subject, text_body, html_body,
                    content_type, merge_context)
        response = get('APIEmailService.addEmailTemplate', title, categories, from, to,
                       cc, bcc, subject, text_body, html_body, content_type, merge_context)
      end

      # This will create an item in the email history for a contact. This does not actually
      # send the email, it only places an item into the email history. Using the API to
      # instruct Infusionsoft to send an email will handle this automatically.
      #
      # @param [Integer] contact_id
      # @param [String] from_name the name portion of the from address, not the email
      # @param [String] from_address
      # @param [String] to_address
      # @param [String] cc_addresses
      # @param [String] bcc_addresses
      # @param [String] content_type can be Text, HTML, Multipart
      # @param [String] subject
      # @param [String] html_body
      # @param [String] text_body
      # @param [String] header the header info for this email (will be listed in history)
      # @param [Date] receive_date
      # @param [Date] sent_date
      def email_attach(contact_id, from_name, from_address, to_address, cc_addresses,
                       bcc_addresses, content_type, subject, html_body, txt_body,
                       header, receive_date, send_date)
        response = get('APIEmailService.attachEmail', contact_id, from_name, from_address,
                       to_address, cc_addresses, bcc_addresses, content_type, subject,
                       html_body, txt_body, header, receive_date, send_date)
      end

      # This retrieves all possible merge fields for the context provided.
      #
      # @param [String] merge_context could include Contact, ServiceCall, Opportunity, or CreditCard
      # @return [Array] returns the merge fields for the given context
      def email_get_available_merge_fields(merge_context)
        response = get('APIEmailService.getAvailableMergeFields', merge_context)
      end

      # Retrieves the details for a particular email template.
      #
      # @param [Integer] id
      # @return [Hash] all data for the email template
      def email_get_template(id)
        response = get('APIEmailService.getEmailTemplate', id)
      end

      # Retrieves the status of the given email address.
      #
      # @param [String] email_address
      # @return [Integer]  0 = opted out, 1 = single opt-in, 2 = double opt-in
      def email_get_opt_status(email_address)
        response = get('APIEmailService.getOptStatus', email_address)
      end

      # This method opts-in an email address. This method only works the first time
      # an email address opts-in.
      #
      # @param [String] email_address
      # @param [String] reason
      #   This is how you can note why/how this email was opted-in. If a blank
      #   reason is passed the system will default a reason of "API Opt In"
      # @return [Boolean]
      def email_optin(email_address, reason)
        response = get('APIEmailService.optIn', email_address, reason)
      end

      # Opts-out an email address. Note that once an address is opt-out,
      # the API cannot opt it back in.
      #
      # @param [String] email_address
      # @param [String] reason
      # @return [Boolean]
      def email_optout(email_address, reason)
        response = get('APIEmailService.optOut', email_address, reason)
      end

      # This will send an email to a list of contacts, as well as record the email
      # in the contacts' email history.
      #
      # @param [Array<Integer>] contact_list list of contact ids you want to send this email to
      # @param [String] from_address
      # @param [String] to_address
      # @param [String] cc_address
      # @param [String] bcc_address
      # @param [String] content_type this must be one of the following Text, HTML, or Multipart
      # @param [String] subject
      # @param [String] html_body
      # @param [String] text_body
      # @return [Boolean] returns true/false if the email has been sent
      def email_send(contact_list, from_address, to_address, cc_addresses,
                     bcc_addresses, content_type, subject, html_body, text_body)
        response = get('APIEmailService.sendEmail', contact_list, from_address,
                       to_address, cc_addresses, bcc_addresses, content_type, subject,
                       html_body, text_body)
      end

      # This will send an email to a list of contacts, as well as record the email in the
      # contacts' email history.
      #
      # @param [Array<Integer>] contact_list is an array of Contact id numbers you would like to send this email to
      # @param [String] The Id of the template to send
      # @return returns true if the email has been sent, an error will be sent back otherwise.      
      def email_send_template(contact_list, template_id)
        response = get('APIEmailService.sendEmail', contact_list, template_id)
      end


      # This method is used to update an already existing email template.
      #
      # @param [Integer] id
      # @param [String] title
      # @param [String] category
      # @param [String] from
      # @param [String] to
      # @param [String] cc
      # @param [String] bcc
      # @param [String subject
      # @param [String] text_body
      # @param [String] html_body
      # @param [String] content_type can be Text, HTML, Multipart
      # @param [String] merge_context can be Contact, ServiceCall, Opportunity, CreditCard
      # @return [Boolean] returns true/false if teamplate was updated successfully
      def email_update_template(id, title, category, from, to, cc, bcc, subject,
                                text_body, html_body, content_type, merge_context)
        response = get('APIEmailService.updateEmailTemplate', id, title, category, from,
                       to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
      end
    end
  end
end
