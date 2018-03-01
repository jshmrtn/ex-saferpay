defmodule ExSaferpay.Request.TransactionAuthorizeDirect do
  @moduledoc """
  Request Body for http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_AuthorizeDirect
  """

  use ExSaferpay.RequestNormalizer

  alias ExSaferpay.Request

  @type t :: %__MODULE__{
          request_header: Request.RequestHeader,
          terminal_id: String.t(),
          payment: Request.Payment.t(),
          payment_means: Request.PaymentMeans.t(),
          register_alias: nil | Request.RegisterAlias.t(),
          payer: nil | Request.Payer.t()
        }

  @enforce_keys [
    :request_header,
    :terminal_id,
    :payment,
    :payment_means
  ]
  defstruct @enforce_keys ++
              [
                :register_alias,
                :payer
              ]

  def new(attrs), do: struct!(__MODULE__, attrs)

  def generate(attrs) do
    %{
      request_header: Request.RequestHeader.generate(),
      terminal_id: Application.fetch_env!(:ex_saferpay, :terminal_id)
    }
    |> Map.merge(attrs)
    |> new
  end
end
