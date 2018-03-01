defmodule ExSaferpay.Request.Payer do
  @moduledoc """
  Request Body for Payer
  """

  use ExSaferpay.RequestNormalizer
  alias ExSaferpay.Request

  @type t :: %__MODULE__{
          ip_address: nil | String.t(),
          language_code: nil | Request.language(),
          delivery_address: nil | Request.Address.t(),
          billing_address: nil | Request.Address.t()
        }

  @enforce_keys []
  defstruct @enforce_keys ++
              [
                :ip_address,
                :language_code,
                :delivery_address,
                :billing_address
              ]
end
