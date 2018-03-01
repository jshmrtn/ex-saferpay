defmodule ExSaferpay.Request.Check do
  @moduledoc """
  Request Body for Check
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          type: :online,
          terminal_id: String.t()
        }

  @enforce_keys [
    :type,
    :terminal_id
  ]
  defstruct @enforce_keys
end
