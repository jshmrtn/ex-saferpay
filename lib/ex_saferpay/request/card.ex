defmodule ExSaferpay.Request.Card do
  @moduledoc """
  Request Body for Card
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          number: String.t(),
          exp_year: String.t(),
          exp_month: String.t(),
          holder_name: nil | String.t(),
          verification_code: nil | String.t()
        }

  @enforce_keys [
    :number,
    :exp_year,
    :exp_month
  ]
  defstruct @enforce_keys ++
              [
                :holder_name,
                :verification_code
              ]
end
