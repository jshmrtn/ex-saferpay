defmodule ExSaferpay.Request.Alias do
  @moduledoc """
  Request Body for Alias
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
    id: String.t,
    verification_code: nil | String.t,
  }

  @enforce_keys [
    :id,
  ]
  defstruct @enforce_keys ++ [
    :verification_code,
  ]
end
