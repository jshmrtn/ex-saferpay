defmodule ExSaferpay.Response.Transaction do
  @moduledoc """
  See `Transaction` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type type :: :payment
  @type status :: :authorized |
    :captured |
    :pending

  @type t :: %__MODULE__{
    type: type,
    status: status,
    id: String.t,
    date: DateTime.t,
    amount: Response.Amount.t,
    order_id: nil | String.t,
    acquirer_name: nil | String.t,
    acquirer_reference: nil | String.t,
    six_transaction_reference: String.t,
    approval_code: nil | String.t,
    direct_debit: nil | Response.DirectDebit.t,
    invoice: nil | Response.Invoice.t,
  }

  defstruct [
    :type,
    :status,
    :id,
    :date,
    :amount,
    :order_id,
    :acquirer_name,
    :acquirer_reference,
    :six_transaction_reference,
    :approval_code,
    :direct_debit,
    :invoice,
  ]

  def empty do
    %__MODULE__{
      type: :atom,
      status: :atom,
      date: DateTime,
      amount: Money,
      direct_debit: Response.DirectDebit.empty(),
      invoice: Response.Invoice.empty(),
    }
  end
end
