defmodule Prosapient.Post do
  use Ecto.Schema
  alias Prosapient.User

  schema "posts" do
    field(:kind, :string)
    field(:text, :string)
    belongs_to(:user, User)
    timestamps()
  end
end
