defmodule ExSaferpay.Response.PaymentMeans do
  @moduledoc """
  See `PaymentMeans` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
          brand: Response.Brand.t(),
          display_text: String.t(),
          wallet: nil | String.t(),
          card: nil | Response.Card.t(),
          bank_account: nil | Response.BankAccount.t()
        }

  defstruct [
    :brand,
    :display_text,
    :wallet,
    :card,
    :bank_account
  ]

  def empty do
    %__MODULE__{
      brand: Response.Brand.empty(),
      card: Response.Card.empty(),
      bank_account: Response.BankAccount.empty()
    }
  end
end
