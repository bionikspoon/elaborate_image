defmodule ElaborateImage.ImagesTest do
  use ExUnit.Case, async: true

  alias ElaborateImage.Images
  alias Exredis.Api, as: R

  @url "https://s3.amazonaws.com/elaborate-image/demo/resized/pexels-photo-736008.jpeg"

  setup do
    R.flushall()
  end

  describe "find/2" do
    test "returns an undefined url result" do
      assert Images.find(@url) === {:error, :undefined}
    end

    test "returns an defined url result" do
      R.set(@url, "https://example.com/image.jpeg")

      assert Images.find(@url) === {:ok, "https://example.com/image.jpeg"}
    end
  end
end
