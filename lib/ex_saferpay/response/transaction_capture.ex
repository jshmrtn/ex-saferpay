defmodule ExSaferpay.Response.TransactionCapture do
  @moduledoc """
  See `TransactionCapture` http://saferpay.github.io/jsonapi/1.8/
  """

  alias ExSaferpay.Response

  @type status :: :pending | :captured

  @type t :: %__MODULE__{
          response_header: Response.ResponseHeader.t(),
          transaction_id: String.t(),
          order_id: nil | String.t(),
          status: status,
          date: nil | DateTime.t(),
          invoice: nil | Response.Invoice.t()
        }

  defstruct [
    :response_header,
    :transaction_id,
    :order_id,
    :status,
    :date,
    :invoice
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      date: DateTime,
      invoice: Response.Invoice.empty(),
      status: :atom
    }
  end
end
