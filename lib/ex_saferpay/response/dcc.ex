defmodule ExSaferpay.Response.Dcc do
  @moduledoc """
  See `Dcc` http://saferpay.github.io/jsonapi/1.8/
  """

  @type t :: %__MODULE__{
          payer_amount: Money.t()
        }

  defstruct [
    :payer_amount
  ]

  def empty do
    %__MODULE__{
      payer_amount: Money
    }
  end
end
