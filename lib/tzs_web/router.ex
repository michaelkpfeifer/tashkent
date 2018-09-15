defmodule TZSWeb.Router do
  use TZSWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TZSWeb do
    pipe_through :api
  end
end
