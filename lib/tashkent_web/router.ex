defmodule TashkentWeb.Router do
  use TashkentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TashkentWeb do
    pipe_through :api

    post "/timezone/lookup", TimezoneController, :lookup
  end
end
