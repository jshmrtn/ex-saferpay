defmodule ExSaferpay.Request.PendingNotification do
  @moduledoc """
  Request Body for PendingNotification
  """

  use ExSaferpay.RequestNormalizer

  @type t :: %__MODULE__{
    merchant_email: nil | String.t,
    notify_url: nil | String.t,
  }

  @enforce_keys []
  defstruct @enforce_keys ++ [
    :merchant_email,
    :notify_url,
  ]
end
