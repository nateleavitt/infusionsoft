module Infusionsoft
  class Client
    ########################
    ###  Email Service   ###
    ########################
    module Email
      # Enables you to opt contacts in
      #
      # @email [String]
      # @reason [String]
      def email_optin(email, reason)
        response = get('APIEmailService', 'optIn', email, reason)
      end

      # Enables you to opt contacts out
      #
      # @email [String]
      # @reason [String]
      def email_optout(email, reason)
        response = get('APIEmailService', 'optOut', email, reason)
      end

      # Sends an email through infusion
      #
      # @contact_list [Array] List of contact ids you want to send this email to
      # @from_address [String]
      # @to_address [String]
      # @cc_address [String]
      # @bcc_address [String]
      # @content_type [String] this must be one of the following Text, HTML, or Multipart
      # @subject [String]
      # @html_body [Text]
      # @text_body [Text]
      def email_send(contact_list, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, text_body)
        response = get('APIEmailService', 'sendEmail', contact_list, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, text_body)
      end

      # adds an email template for future use
      #
      # @title [String]
      # @categories [String] a comma separated list of the categories you wan this template in Infusionsoft
      # @content_type [String] can be Text, HTML, Multipart
      # @text_body [Text]
      # @html_body [Text]
      # @merge_context [String] can be Contact, ServiceCall, Opportunity, CreditCard
      def email_add(title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
        response = get('APIEmailService', 'addEmailTemplate', title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
      end

      # Attaches an email to a contact record
      def email_attach(contact_id, from_name, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body, header, receive_date, send_date)
        response = get('APIEmailService', 'attachEmail', contact_id, from_name, from_address, to_address, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body, header, receive_date, send_date)
      end

      # Creates an email template
      def email_create_template(title, user_id, from_address, to_addres, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
        response = get('APIEmailService', 'createEmailTemplate', title, user_id, from_address, to_addres, cc_addresses, bcc_addresses, content_type, subject, html_body, txt_body)
      end

      # updates an email template for future use
      #
      # @categories [String] a comma separated list of the categories you wan this template in Infusionsoft
      # @content_type [String] can be Text, HTML, Multipart
      # @merge_context [String] can be Contact, ServiceCall, Opportunity, CreditCard
      def email_update_template(id, title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type, merge_context)
        response = get('APIEmailService', 'updateEmailTemplate', title, categories, from, to, cc, bcc, subject, text_body, html_body, content_type)
      end

      # returns an email template
      def email_get_template(id)
        response = get('APIEmailService', 'getEmailTemplate', id)
      end

      # gets the opt-in status of the provided email address
      #
      # email_address [String]
      # @returns 0 = opted out; 1 = single opt-in; 2 = double opt-in
      def email_get_opt_status(email_address)
        response = get('APIEmailService', 'getOptStatus', email_address)
      end

      # returns a string of merge fields for a given context
      #
      # @merge_context [String] could include Contact, ServiceCall, Opportunity, CreditCard
      def email_get_available_merge_fields(merge_context)
        response = get('APIEmailService', 'getAvailableMergeFields', merge_context)
      end

    end
  end
end
