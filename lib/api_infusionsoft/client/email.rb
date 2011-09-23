module ApiInfusionsoft
  class Client
    ########################
    ###  Email Service   ###
    ########################
    module EmailService
      # Enables you to opt contacts in
      def api_email_optin(email, reason)
        response = get('APIEmailService', 'optIn', email, reason)
      end

      # Enables you to opt contacts out
      def api_email_optout(email, reason)
        response = get('APIEmailService', 'optOut', email, reason)
      end

      # Sends an email through infusion
      def api_email_send(contact_list, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
        response = get('APIEmailService', 'sendEmail', contact_list, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
      end
      
      # adds an email template for future use
      # categories are a comma separated list of the categories you wan this template in Infusionsoft
      # content_type can be Text, HTML, Multipart
      # merge_context can be Contact, ServiceCall, Opportunity, CreditCard
      def api_email_add(title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
        response = get('APIEmailService', 'addEmailTemplate', title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
      end

      # Attaches an email to a contact record
      def api_email_attach(contact_id, from_name, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body, header, receive_date, send_date)
        response = get('APIEmailService', 'attachEmail', contact_id, from_name, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body, header, receive_date, send_date)
      end

      # Creates an email template
      def api_email_create_template(title, user_id, from_address, to_addres, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
        response = get('APIEmailService', 'createEmailTemplate', title, user_id, from_address, to_addres, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
      end
      
      # updates an email template for future use
      # categories are a comma separated list of the categories you wan this template in Infusionsoft
      # content_type can be Text, HTML, Multipart
      # merge_context can be Contact, ServiceCall, Opportunity, CreditCard
      def api_email_update_template(id, title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
        response = get('APIEmailService', 'updateEmailTemplate', title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type)
      end
      
      # returns an email template
      def api_email_get_template(id)
        response = get('APIEmailService', 'getEmailTemplate', id)
      end
      
      # gets the opt-in status of the provided email address
      # 0 = opted out; 1 = single opt-in; 2 = double opt-in
      def api_email_get_opt_status(email_address)
        response = get('APIEmailService', 'getOptStatus', email_address)
      end
      
      # returns a string of merge fields for a given context
      # context could include Contact, ServiceCall, Opportunity, CreditCard
      def api_email_get_available_merge_fields(merge_context)
        response = get('APIEmailService', 'getAvailableMergeFields', merge_context)
      end

    end
  end
end
