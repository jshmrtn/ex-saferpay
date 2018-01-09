defmodule ExSaferpay.Response.BankAccount do
  @moduledoc """
  Response Body for BankAccount
  """

  @type t :: %__MODULE__{
    iban: String.t,
    holder_name: nil | String.t,
    bic: nil | String.t,
    bank_name: nil | String.t,
  }

  defstruct [
    :iban,
    :holder_name,
    :bic,
    :bank_name,
  ]

  def empty do
    %__MODULE__{}
  end
end
