defmodule ExSaferpay.Response.Invoice do
  @moduledoc """
  See `Invoice` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
          payee: nil | Response.Payee.t(),
          reason_for_transfer: nil | String.t(),
          due_date: nil | DateTime.t()
        }

  defstruct [
    :payee,
    :reason_for_transfer,
    :due_date
  ]

  def empty do
    %__MODULE__{
      payee: Response.Payee.empty(),
      due_date: DateTime
    }
  end
end
