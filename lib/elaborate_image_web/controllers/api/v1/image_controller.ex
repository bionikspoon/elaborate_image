defmodule ElaborateImageWeb.Api.V1.ImageController do
  use ElaborateImageWeb, :controller

  def resize(conn, %{"url" => url}) do
    conn
    |> put_status(307)
    |> redirect(external: url)
    |> halt()
  end
end
