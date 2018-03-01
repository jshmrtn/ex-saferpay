defmodule ExSaferpay.Request.Options do
  @moduledoc """
  Payment Options
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          pre_auth: nil | boolean
        }

  @enforce_keys []
  defstruct @enforce_keys ++
              [
                :pre_auth
              ]
end
