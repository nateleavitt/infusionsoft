module FileService

  ########################
  ###  File Service  ###
  ########################

  def api_file_upload(contact_id, file_name, encoded_file_base64)
    Thread.current[:api_conn].api_perform('FileService', 'uploadFile', contact_id, file_name, encoded_file_base64)
  end

  # returns the Base64 encoded file contents
  def api_file_get(id)
    Thread.current[:api_conn].api_perform('FileService', 'getFile', id)
  end

  def api_file_url(id)
    Thread.current[:api_conn].api_perform('FileService', 'getDownloadUrl', id)
  end

  def api_file_rename(id, new_name)
    Thread.current[:api_conn].api_perform('FileService', 'renameFile', id, new_name)
  end

  def api_file_replace(id, encoded_file_base64)
    Thread.current[:api_conn].api_perform('FileService', 'replaceFile', id, encoded_file_base64)
  end
end
