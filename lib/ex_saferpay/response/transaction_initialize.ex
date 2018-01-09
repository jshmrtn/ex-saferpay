defmodule ExSaferpay.Response.TransactionInitialize do
  @moduledoc """
  See `TransactionInitialize` http://saferpay.github.io/jsonapi/1.8/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
    response_header: Response.ResponseHeader.t,
    token: String.t,
    expiration: DateTime.t,
    liability_shift: nil | boolean,
    redirect_required: boolean,
    redirect: nil | Response.Redirect.t,
  }

  defstruct [
    :response_header,
    :token,
    :expiration,
    :liability_shift,
    :redirect_required,
    :redirect,
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      expiration: DateTime,
      redirect: Response.Redirect.empty(),
    }
  end
end
