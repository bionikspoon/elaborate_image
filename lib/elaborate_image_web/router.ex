defmodule ElaborateImageWeb.Router do
  use ElaborateImageWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElaborateImageWeb do
    pipe_through :api
  end
end
