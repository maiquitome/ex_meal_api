# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_meal,
  ecto_repos: [ExMeal.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :ex_meal, ExMealWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wo8UMU0XkL7adnuqC4cN5I63K9pTJ++3vML+lpAb9vBAixPVaKrTctLiJBb5IknP",
  render_errors: [view: ExMealWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExMeal.PubSub,
  live_view: [signing_salt: "vxcMo9RK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
