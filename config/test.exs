use Mix.Config

config :prosapient, Prosapient.Repo,
  adapter: Sqlite.Ecto2,
  database: "prosapient_test.sqlite3"

config :prosapient, ecto_repos: [Prosapient.Repo]
config :logger, level: :info
