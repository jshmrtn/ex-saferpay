defmodule ExSaferpay.Response.TransactionAuthorizeReferenced do
  @moduledoc """
  See `TransactionAuthorizeReferenced` http://saferpay.github.io/jsonapi/1.8/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
    response_header: Response.ResponseHeader.t,
    transaction: Response.Transaction.t,
    payment_means: Response.PaymentMeans.t,
    payer: nil | Response.Payer.t,
    dcc: nil | Response.Dcc.t,
  }

  defstruct [
    :response_header,
    :transaction,
    :payment_means,
    :payer,
    :dcc,
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      transaction: Response.Transaction.empty(),
      payment_means: Response.PaymentMeans.empty(),
      payer: Response.Payer.empty(),
      dcc: Response.Dcc.empty(),
    }
  end
end
