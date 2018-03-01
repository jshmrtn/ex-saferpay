defmodule ExSaferpay.Request.TransactionReference do
  @moduledoc """
  Request Body for TransactionReference
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          transaction_id: nil | String.t(),
          order_id: nil | String.t()
        }

  @enforce_keys []
  defstruct @enforce_keys ++
              [
                :transaction_id,
                :order_id
              ]
end
