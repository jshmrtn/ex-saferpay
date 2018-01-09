defmodule ExSaferpay.Response.ThreeDs do
  @moduledoc """
  See `ThreeDs` http://saferpay.github.io/jsonapi/1.8/
  """

  @type t :: %__MODULE__{
    authenticated: boolean,
    liability_shift: boolean,
    xid: String.t,
    verification_value: nil | String.t,
  }

  defstruct [
    :authenticated,
    :liability_shift,
    :xid,
    :verification_value,
  ]

  def empty do
    %__MODULE__{}
  end
end
