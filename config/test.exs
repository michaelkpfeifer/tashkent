use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tashkent, TashkentWeb.Endpoint,
  http: [port: 4011],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tashkent, Tashkent.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "scratch",
  password: "scratch",
  database: "tashkent_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
