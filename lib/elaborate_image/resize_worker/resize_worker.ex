defmodule ElaborateImage.ResizeWorker do
  @moduledoc """
  Module to resize images.
  """

  def perform(url) do
    IO.puts(url)
  end

  def enqueue(url) do
    Exq.enqueue(Exq, "default", ElaborateImage.ResizeWorker, [url])
  end
end
