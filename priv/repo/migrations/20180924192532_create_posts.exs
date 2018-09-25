defmodule Prosapient.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :kind, :string
      add :text, :string
      add :user_id, references(:users)
      timestamps()
    end
  end
end
