defmodule ElaborateImage.ImagesTest do
  use ExUnit.Case, async: true

  alias ElaborateImage.Images

  describe "get/2" do
    @url "https://s3.amazonaws.com/elaborate-image/demo/resized/pexels-photo-736008.jpeg"

    test "returns a url result" do
      assert Images.get(@url) === {:error}
    end
  end
end
