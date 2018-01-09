defmodule ExSaferpay.Response.AliasInsertDirect do
  @moduledoc """
  See `AliasInsertDirect` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
    response_header: Response.ResponseHeader.t,
    alias: Response.Alias.t,
    payment_means: Response.PaymentMeans.t,
    check_result: nil | Response.CheckResult.t,
  }

  defstruct [
    :response_header,
    :alias,
    :payment_means,
    :check_result,
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      alias: Response.Alias.empty(),
      payment_means: Response.PaymentMeans.empty(),
      check_result: Response.CheckResult.empty(),
    }
  end
end
