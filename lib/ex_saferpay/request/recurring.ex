defmodule ExSaferpay.Request.Recurring do
  @moduledoc """
  Payment Initial
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
    initial: boolean,
  }

  @enforce_keys [
    :initial,
  ]
  defstruct @enforce_keys
end
