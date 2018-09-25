defmodule Prosapient.Repo do
  use Ecto.Repo, otp_app: :prosapient, adapter: Sqlite.Ecto2
end
