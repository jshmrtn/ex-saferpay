defmodule ExSaferpay.Request.Billpay do
  @moduledoc """
  Request Body for Billpay
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          delay_in_days: nil | non_neg_integer
        }

  @enforce_keys []
  defstruct @enforce_keys ++
              [
                :delay_in_days
              ]
end
