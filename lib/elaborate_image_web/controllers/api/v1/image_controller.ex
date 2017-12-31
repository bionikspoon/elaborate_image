defmodule ElaborateImageWeb.Api.V1.ImageController do
  use ElaborateImageWeb, :controller
  alias ElaborateImage.Images

  def resize(conn, %{"url" => url}) do
    case Images.get(url) do
      {:error, _} -> conn |> temp_redirect(url)
      {:ok, url} -> conn |> perm_redirect(url)
    end
  end

  defp temp_redirect(conn, url) do
    conn
    |> put_status(307)
    |> redirect(external: url)
    |> halt()
  end

  defp perm_redirect(conn, url) do
    conn
    |> put_status(308)
    |> redirect(external: url)
    |> halt()
  end
end
