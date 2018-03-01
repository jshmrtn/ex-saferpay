defmodule ExSaferpay.Request.Partial do
  @moduledoc """
  Request Body for Partial
  """

  use ExSaferpay.RequestNormalizer

  @type type :: :partial | :final

  @type t :: %__MODULE__{
          type: type,
          order_part_id: String.t()
        }

  @enforce_keys [
    :type,
    :order_part_id
  ]
  defstruct @enforce_keys
end
