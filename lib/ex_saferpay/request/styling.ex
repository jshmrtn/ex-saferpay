defmodule ExSaferpay.Request.Styling do
  @moduledoc """
  Request Body for Styling
  """

  use ExSaferpay.RequestNormalizer

  @type theme :: :default |
    :six |
    :none

  @type t :: %__MODULE__{
    css_url: nil | URI.t,
    theme: nil | theme,
  }

  @enforce_keys []
  defstruct @enforce_keys ++ [
    :css_url,
    :theme,
  ]
end
