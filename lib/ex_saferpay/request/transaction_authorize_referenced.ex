defmodule ExSaferpay.Request.TransactionAuthorizeReferenced do
  @moduledoc """
  Request Body for http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_AuthorizeReferenced
  """

  use ExSaferpay.RequestNormalizer

  alias ExSaferpay.Request

  @type t :: %__MODULE__{
      request_header: Request.RequestHeader,
      terminal_id: String.t,
      payment: Request.Payment.t,
      transaction_reference: Request.TransactionReference.t,
      suppress_dcc: nil | boolean()
  }

  @enforce_keys [
    :request_header,
    :terminal_id,
    :payment,
    :transaction_reference,
  ]
  defstruct @enforce_keys ++ [
    :suppress_dcc,
  ]

  def new(attrs), do: struct!(__MODULE__, attrs)

  def generate(attrs) do
    %{
      request_header: Request.RequestHeader.generate(),
      terminal_id: Application.fetch_env!(:ex_saferpay, :terminal_id),
    }
    |> Map.merge(attrs)
    |> new
  end
end
