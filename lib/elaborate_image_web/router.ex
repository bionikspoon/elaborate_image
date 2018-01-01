defmodule ElaborateImageWeb.Router do
  use ElaborateImageWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :exq do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:put_secure_browser_headers)
    plug(ExqUi.RouterPlug, namespace: "exq")
  end

  scope "/1", ElaborateImageWeb.Api.V1, as: :api_v1 do
    pipe_through(:api)

    get("/", ImageController, :resize)
  end

  scope "/exq", ExqUi do
    pipe_through(:exq)

    if Application.get_env(:elaborate_image, :exq_ui, false) do
      forward("/", RouterPlug.Router, :index)
    end
  end
end
