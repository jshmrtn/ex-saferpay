defmodule ExSaferpay.Response.TransactionAuthorize do
  @moduledoc """
  See `TransactionAuthorize` http://saferpay.github.io/jsonapi/1.8/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
          response_header: Response.ResponseHeader.t(),
          transaction: Response.Transaction.t(),
          payment_means: Response.PaymentMeans.t(),
          payer: nil | Response.Payer.t(),
          registration_result: nil | Response.RegistrationResult.t(),
          three_ds: nil | Response.ThreeDs.t(),
          dcc: nil | Response.Dcc.t()
        }

  defstruct [
    :response_header,
    :transaction,
    :payment_means,
    :payer,
    :registration_result,
    :three_ds,
    :dcc
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      transaction: Response.Transaction.empty(),
      payment_means: Response.PaymentMeans.empty(),
      payer: Response.Payer.empty(),
      registration_result: Response.RegistrationResult.empty(),
      three_ds: Response.ThreeDs.empty(),
      dcc: Response.Dcc.empty()
    }
  end
end
