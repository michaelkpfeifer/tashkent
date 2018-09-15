use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tzs, TZSWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tzs, TZS.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "scratch",
  password: "scratch",
  database: "tzs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
