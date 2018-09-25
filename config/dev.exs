use Mix.Config

config :prosapient, Prosapient.Repo,
  adapter: Sqlite.Ecto2,
  database: "prosapient.sqlite3"

config :prosapient, ecto_repos: [Prosapient.Repo]
