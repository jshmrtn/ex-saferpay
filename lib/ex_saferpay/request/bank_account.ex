defmodule ExSaferpay.Request.BankAccount do
  @moduledoc """
  Request Body for BankAccount
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          iban: String.t(),
          holder_name: nil | String.t(),
          bic: nil | String.t(),
          bank_name: nil | String.t()
        }

  @enforce_keys [
    :iban
  ]
  defstruct @enforce_keys ++
              [
                :holder_name,
                :bic,
                :bank_name
              ]
end
