defmodule TashkentWeb.Router do
  use TashkentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", TashkentWeb do
    pipe_through :api

    post "/timezone/lookup", V1.TimezoneController, :lookup
  end
end
