defmodule TZSWeb.Router do
  use TZSWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TZSWeb do
    pipe_through :api

    post "/timezone/lookup", TimezoneController, :lookup
  end
end
