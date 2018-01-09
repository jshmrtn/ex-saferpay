defmodule ExSaferpay.Request.AliasInsertDirect do
  @moduledoc """
  See `AliasInsertDirect` http://saferpay.github.io/jsonapi/1.2/
  """

  use ExSaferpay.RequestNormalizer
  alias ExSaferpay.Request

  @type type :: :card |
    :bank_account |
    :postfinance

  @type t :: %__MODULE__{
    request_header: Request.RequestHeader.t,
    register_alias: Request.RegisterAlias.t,
    payment_means: nil | Request.PaymentMeans.t,
    check: nil | Request.Check.t,
  }

  @enforce_keys [
    :request_header,
    :register_alias,
    :payment_means,
  ]
  defstruct @enforce_keys ++ [
    :check,
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
