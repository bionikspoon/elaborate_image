defmodule ElaborateImageWeb.Router do
  use ElaborateImageWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/1", ElaborateImageWeb.Api.V1, as: :api_v1 do
    pipe_through(:api)

    get("/", ImageController, :resize)
  end
end
