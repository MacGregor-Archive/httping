# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :httping, HTTPingWeb.Endpoint,
  url: [host: System.get_env("HOST") || "localhost"],
  secret_key_base:
    System.get_env("SECRET_KEY_BASE") ||
      "7z2h9xkid4raz+8XhERrgUOLJd+GNdhbTQB537UBUcRDAs7DO8lzyuHDAYqDz+dI",
  render_errors: [view: HTTPingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HTTPing.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt:
      System.get_env("SIGNING_SALT") ||
        "ZWoUIYzwkGuNUWE1NhroWXICHby0GCFEdZ37cqjL/ziBPWaacHuUAve8GOydrFKx"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :httping, HTTPing, api_endpoint: System.get_env("API_ENDPOINT")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
