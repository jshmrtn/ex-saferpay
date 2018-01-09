defmodule ExSaferpay.Request.AliasDelete do
  @moduledoc """
  See `AliasDelete` http://saferpay.github.io/jsonapi/1.2/
  """

  use ExSaferpay.RequestNormalizer
  alias ExSaferpay.Request

  @type t :: %__MODULE__{
    request_header: Request.RequestHeader.t,
    alias_id: String.t,
  }

  @enforce_keys [
    :request_header,
    :alias_id,
  ]
  defstruct @enforce_keys

  def new(attrs), do: struct!(__MODULE__, attrs)

  def generate(attrs) do
    %{
      request_header: Request.RequestHeader.generate(),
    }
    |> Map.merge(attrs)
    |> new
  end
end
