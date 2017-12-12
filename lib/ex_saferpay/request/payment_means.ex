defmodule ExSaferpay.Request.PaymentMeans do
  @moduledoc """
  Request Body for PaymentMeans
  """

  use ExSaferpay.RequestNormalizer
  alias ExSaferpay.Request

  @type t :: %__MODULE__{
    card: nil | Request.Card.t,
    bank_account: nil | Request.BankAccount.t,
    alias: nil | Request.Alias.t,
  }

  @enforce_keys []
  defstruct @enforce_keys ++ [
    :card,
    :bank_account,
    :alias,
  ]
end
