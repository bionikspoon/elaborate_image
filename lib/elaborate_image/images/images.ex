defmodule ElaborateImage.Images do
  @moduledoc """
  Provides access to redis store.
  """
  alias Exredis.Api, as: R

  def find(url) do
    case R.get(url) do
      value when is_atom(value) -> {:error, value}
      value -> {:ok, value}
    end
  end
end
