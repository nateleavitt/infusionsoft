module Infusionsoft
  class Client
    module File
      def file_upload(contact_id, file_name, encoded_file_base64)
        response = get('FileService.uploadFile', contact_id, file_name, encoded_file_base64)
      end

      # returns the Base64 encoded file contents
      def file_get(id)
        response = get('FileService.getFile', id)
      end

      def file_url(id)
        response = get('FileService.getDownloadUrl', id)
      end

      def file_rename(id, new_name)
        response = get('FileService.renameFile', id, new_name)
      end

      def file_replace(id, encoded_file_base64)
        response = get('FileService.replaceFile', id, encoded_file_base64)
      end
    end
  end
end
