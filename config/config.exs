# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :whatsforlunch,
  ecto_repos: [Whatsforlunch.Repo]

# Configures the endpoint
config :whatsforlunch, WhatsforlunchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sE1V6/oB2xuVNdf0d6QX2pojn/2GGoFDfFDmyUGGEyN6NxZVe1akkRoJ6YDY9QMG",
  render_errors: [view: WhatsforlunchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Whatsforlunch.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :whatsforlunch, Whatsforlunch.Yelp.YelpApi, 
  yelp_api_key: System.get_env("YELP_API_KEY")
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"