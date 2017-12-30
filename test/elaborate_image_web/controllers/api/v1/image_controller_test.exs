defmodule ElaborateImageWeb.Api.V1.ImageControllerTest do
  use ElaborateImageWeb.ConnCase, async: true

  describe "resize/2" do
    @redirect_url "https://s3.amazonaws.com/elaborate-image/demo/resized/pexels-photo-736008.jpeg"

    setup %{conn: conn} do
      [
        conn:
          conn
          |> get(
            api_v1_image_path(conn, :resize),
            url: @redirect_url
          )
      ]
    end

    test "Responds with a temporary redirect", %{conn: conn} do
      assert conn.status == 307
    end

    test "Responds with a redirect url", %{conn: conn} do
      assert get_redirect_url!(conn) === @redirect_url
    end
  end

  def get_redirect_url!(conn) do
    conn.resp_headers
    |> Enum.find(fn resp_header -> resp_header |> elem(0) === "location" end)
    |> elem(1)
  end
end
