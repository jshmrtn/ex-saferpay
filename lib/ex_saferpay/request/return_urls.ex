defmodule ExSaferpay.Request.ReturnUrls do
  @moduledoc """
  Request Body for ReturnUrls
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
          success: URI.t(),
          fail: URI.t(),
          abort: nil | URI.t()
        }

  @enforce_keys [
    :success,
    :fail
  ]
  defstruct @enforce_keys ++
              [
                :abort
              ]
end
