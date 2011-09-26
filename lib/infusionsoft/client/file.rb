module Infusionsoft
  class Client
    ########################
    ###  File Service  ###
    ########################
    module File
      def api_file_upload(contact_id, file_name, encoded_file_base64)
        response = get('FileService', 'uploadFile', contact_id, file_name, encoded_file_base64)
      end

      # returns the Base64 encoded file contents
      def api_file_get(id)
        response = get('FileService', 'getFile', id)
      end

      def api_file_url(id)
        response = get('FileService', 'getDownloadUrl', id)
      end

      def api_file_rename(id, new_name)
        response = get('FileService', 'renameFile', id, new_name)
      end

      def api_file_replace(id, encoded_file_base64)
        response = get('FileService', 'replaceFile', id, encoded_file_base64)
      end
    end
  end
end
