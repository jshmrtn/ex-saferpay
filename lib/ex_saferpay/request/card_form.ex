defmodule ExSaferpay.Request.CardForm do
  @moduledoc """
  Request Body for CardForm
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          holder_name: nil | String.t()
        }

  @enforce_keys []
  defstruct @enforce_keys ++
              [
                :holder_name
              ]
end
