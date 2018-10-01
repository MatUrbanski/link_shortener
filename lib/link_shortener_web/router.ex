defmodule LinkShortenerWeb.Router do
  use LinkShortenerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", LinkShortenerWeb do
    pipe_through(:api)
    resources("/links", LinkController, except: [:edit, :new])
  end

  scope "/", LinkShortenerWeb do
    get "/:id", LinkController, :get_and_redirect
  end
end
