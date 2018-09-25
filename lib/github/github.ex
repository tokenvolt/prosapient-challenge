defmodule Prosapient.Github do
  @host "https://api.github.com"
  @default_headers [
    {'User-Agent', 'Prosapient-Challenge'},
    {'Content-Type', 'application/json'}
  ]

  def stars(github_path) do
    path = "/repos/"
    uri = URI.merge(@host, path) |> URI.merge(github_path) |> to_string
    request = {uri |> to_charlist, @default_headers}
    http_options = [ssl: [{:versions, [:"tlsv1.2"]}]]

    with {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, json}} <-
           :httpc.request(
             :get,
             request,
             http_options,
             []
           ),
         {:ok, decoded_json} <- Poison.decode(json) do
      {:ok, Map.get(decoded_json, "watchers", 0)}
    else
      {:ok, {{'HTTP/1.1', 404, _}, _headers, _body}} -> {:error, "repo is private"}
    end
  end
end
