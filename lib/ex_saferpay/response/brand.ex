defmodule ExSaferpay.Response.Brand do
  @moduledoc """
  See `Brand` http://saferpay.github.io/jsonapi/1.2/
  """

  @type payment_method :: :amex |
    :bancontact |
    :bonus |
    :diners |
    :directdebit |
    :eprzelewy |
    :eps |
    :giropay |
    :ideal |
    :invoice |
    :jcb |
    :maestro |
    :mastercard |
    :myone |
    :paypal |
    :paydirekt |
    :postcard |
    :postfinance |
    :saferpaytest |
    :sofort |
    :twint |
    :visa

  @type t :: %__MODULE__{
    payment_method: nil | payment_method,
    name: String.t,
  }

  defstruct [
    :payment_method,
    :name,
  ]

  def empty do
    %__MODULE__{
      payment_method: :atom,
    }
  end
end
