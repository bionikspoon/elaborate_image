defmodule ElaborateImageWeb.Api.V1.ImageControllerTest do
  use ElaborateImageWeb.ConnCase, async: true
  alias Exredis.Api, as: R

  @url "https://s3.amazonaws.com/elaborate-image/demo/resized/pexels-photo-736008.jpeg"

  describe "resize/2 with an uncached url" do
    setup [:clear_cache, :unsub_queues, :fetch_path]

    test "Responds with a temporary redirect", %{conn: conn} do
      assert conn.status == 307
    end

    test "Responds with a redirect url", %{conn: conn} do
      assert get_redirect_url!(conn) === @url
    end

    test "Enqueues 1 resize job" do
      {:ok, queue_size} = Exq.Api.queue_size(Exq.Api, "default")

      assert queue_size === 1
    end
  end

  describe "resize/2 with cached url" do
    setup [:clear_cache, :unsub_queues, :cache_url, :fetch_path]

    test "Responds with a permenant redirect", %{conn: conn} do
      assert conn.status == 308
    end

    test "Responds with a redirect url", %{conn: conn} do
      assert get_redirect_url!(conn) === "https://example.com/image.jpeg"
    end

    test "Enqueues 0 resize jobs" do
      {:ok, queue_size} = Exq.Api.queue_size(Exq.Api, "default")

      assert queue_size === 0
    end
  end

  defp clear_cache(_context) do
    R.flushall()
  end

  defp unsub_queues(_context) do
    Exq.unsubscribe_all(Exq)
  end

  defp cache_url(_context) do
    R.set(@url, "https://example.com/image.jpeg")
  end

  defp fetch_path(%{conn: conn}) do
    [
      conn:
        conn
        |> get(
          api_v1_image_path(conn, :resize),
          url: @url
        )
    ]
  end

  defp get_redirect_url!(conn) do
    conn.resp_headers
    |> Enum.find(fn resp_header -> resp_header |> elem(0) === "location" end)
    |> elem(1)
  end
end
