defmodule ExTwitter.API.Media do
  @moduledoc """
  Provides Tweets API interfaces.
  """

  import ExTwitter.API.Base

  def upload(data, options \\ []) do
    params = ExTwitter.Parser.parse_request_params([media: data] ++ options)
    upload_request(:post, "1.1/media/upload.json", params)
    |> ExTwitter.Parser.parse_upload
  end

  def upload_init(data, options \\ []) do
    params = ExTwitter.Parser.parse_request_params([
      command: "INIT", media_type: "video/mp4", total_bytes: byte_size(data)] ++ options)
    upload_request(:post, "1.1/media/upload.json", params)
    |> ExTwitter.Parser.parse_upload
  end

  def upload_append(data, media_id, segment, options \\ []) do
    params = ExTwitter.Parser.parse_request_params([
      command: "APPEND", media: data, media_id: media_id, segment_index: segment])
    upload_request(:post, "1.1/media/upload.json", params)
    |> ExTwitter.Parser.parse_upload
  end

  def upload_finalize(data, options \\ []) do
    params = ExTwitter.Parser.parse_request_params([
      command: "FINALIZE", media_id: data])
    upload_request(:post, "1.1/media/upload.json", params)
    |> ExTwitter.Parser.parse_upload
  end

  # def update_with_media(status, media_content, options \\ []) do
  #   encoded_media_content = Base.encode64(media_content)
  #   response = upload(encoded_media_content)
  #   update(status, [media_ids: response.media_id] ++ options)
  # end

  # defp upload(data, options \\ []) do
  #   params = ExTwitter.Parser.parse_request_params([media: data] ++ options)
  #   upload_request(:post, "1.1/media/upload.json", params)
  #   |> ExTwitter.Parser.parse_upload
  # end
end
