defmodule ExSaferpay.Response.TransactionAuthorizeDirect do
  @moduledoc """
  See `TransactionAuthorizeDirect` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
    response_header: Response.ResponseHeader.t,
    transaction: Response.Transaction.t,
    payment_means: Response.PaymentMeans.t,
    payer: nil | Response.Payer.t,
    registration_result: nil | Response.RegistrationResult.t,
  }

  defstruct [
    :response_header,
    :transaction,
    :payment_means,
    :payer,
    :registration_result,
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      transaction: Response.Transaction.empty(),
      payment_means: Response.PaymentMeans.empty(),
      payer: Response.Payer.empty(),
      registration_result: Response.RegistrationResult.empty(),
    }
  end
end
