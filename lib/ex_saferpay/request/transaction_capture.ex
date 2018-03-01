defmodule ExSaferpay.Request.TransactionCapture do
  @moduledoc """
  Request Body for http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_Capture
  """

  use ExSaferpay.RequestNormalizer

  alias ExSaferpay.Request

  @type t :: %__MODULE__{
          request_header: Request.RequestHeader.t(),
          transaction_reference: Request.TransactionReference.t(),
          amount: nil | Request.Amount.t(),
          billpay: nil | Request.Billpay.t(),
          partial: nil | Request.Partial.t(),
          pending_notification: Request.PendingNotification.t()
        }

  @enforce_keys [
    :request_header,
    :transaction_reference
  ]
  defstruct @enforce_keys ++
              [
                :amount,
                :billpay,
                :partial,
                :pending_notification
              ]

  def new(attrs), do: struct!(__MODULE__, attrs)

  def generate(attrs) do
    %{
      request_header: Request.RequestHeader.generate()
    }
    |> Map.merge(attrs)
    |> new
  end
end
