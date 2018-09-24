# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :link_shortener,
  ecto_repos: [LinkShortener.Repo]

# Configures the endpoint
config :link_shortener, LinkShortenerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SFnIo+ueU2ybrb4F+bGSaxTUEqwSRDj9/0UvRcMdXvwu2AVirMKDMC7mUmhyN/xP",
  render_errors: [view: LinkShortenerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LinkShortener.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
