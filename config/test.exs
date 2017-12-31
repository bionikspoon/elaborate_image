use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elaborate_image, ElaborateImageWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :exredis,
  host: "0.0.0.0",
  port: 6378,
  db: 0,
  reconnect: :no_reconnect,
  max_queue: :infinity
