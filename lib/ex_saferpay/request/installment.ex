defmodule ExSaferpay.Request.Installment do
  @moduledoc """
  Payment Installment
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          initial: boolean
        }

  @enforce_keys [
    :initial
  ]
  defstruct @enforce_keys
end
