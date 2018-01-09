defmodule ExSaferpay.Response.Payer do
  @moduledoc """
  See `Payer` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
    id_address: nil | String.t,
    ip_location: nil | String.t,
    delivery_address: nil | Response.Address.t,
    billing_address: nil | Response.Address.t,
  }

  defstruct [
    :id_address,
    :ip_location,
    :delivery_address,
    :billing_address,
  ]

  def empty do
    %__MODULE__{
      delivery_address: Response.Address.empty(),
      billing_address: Response.Address.empty(),
    }
  end
end
