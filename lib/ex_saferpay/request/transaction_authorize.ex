defmodule ExSaferpay.Request.TransactionAuthorize do
  @moduledoc """
  Request Body for http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_Authorize
  """

  use ExSaferpay.RequestNormalizer

  alias ExSaferpay.Request

  @type condition :: :with_liability_shift

  @type t :: %__MODULE__{
      request_header: Request.RequestHeader,
      token: String.t,
      condition: nil | condition,
      verification_code: nil | String.t,
      register_alias: nil | Request.RegisterAlias.t,
  }

  @enforce_keys [
    :request_header,
    :token,
  ]
  defstruct @enforce_keys ++ [
    :condition,
    :verification_code,
    :register_alias,
  ]

  def new(attrs), do: struct!(__MODULE__, attrs)

  def generate(attrs) do
    %{
      request_header: Request.RequestHeader.generate(),
    }
    |> Map.merge(attrs)
    |> new
  end
end
