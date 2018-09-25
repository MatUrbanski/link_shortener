defmodule LinkShortenerWeb.Router do
  use LinkShortenerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", LinkShortenerWeb do
    pipe_through(:api)
    resources("/links", LinkController, except: [:edit, :new])
  end
end
