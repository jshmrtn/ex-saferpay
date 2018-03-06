defmodule ExSaferpay.Request.TransactionInitialize do
  @moduledoc """
  Request Body for http://saferpay.github.io/jsonapi/1.2/#Payment_v1_Transaction_Initialize
  """

  use ExSaferpay.RequestNormalizer

  alias ExSaferpay.Request
  alias ExSaferpay.Util

  @type t :: %__MODULE__{
          request_header: Request.RequestHeader,
          terminal_id: String.t(),
          payment: Request.Payment.t(),
          payment_means: nil | Request.PaymentMeans.t(),
          payer: nil | Request.Payer.t(),
          return_urls: Request.ReturnUrls.t(),
          styling: nil | Request.Styling.t()
        }

  @enforce_keys [
    :request_header,
    :terminal_id,
    :payment,
    :return_urls
  ]
  defstruct @enforce_keys ++
              [
                :payment_means,
                :payer,
                :styling
              ]

  def new(attrs), do: struct!(__MODULE__, attrs)

  def generate(attrs) do
    %{
      request_header: Request.RequestHeader.generate(),
      terminal_id: Util.terminal_id()
    }
    |> Map.merge(attrs)
    |> new
  end
end
