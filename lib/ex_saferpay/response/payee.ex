defmodule ExSaferpay.Response.Payee do
  @moduledoc """
  See `Payee` http://saferpay.github.io/jsonapi/1.2/
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
