defmodule ExSaferpay.Request.AliasInsert do
  @moduledoc """
  See `AliasInsert` http://saferpay.github.io/jsonapi/1.2/
  """

  use ExSaferpay.RequestNormalizer
  alias ExSaferpay.Request

  @type type :: :card |
    :bank_account |
    :postfinance

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
    request_header: Request.RequestHeader.t,
    register_alias: Request.RegisterAlias.t,
    type: type,
    return_urls: Request.ReturnUrls.t,
    styling: nil | Request.Styling.t,
    language_code: nil | Request.language,
    check: nil | Request.Check.t,
    payment_methods: nil | [payment_method],
    card_form: nil | Request.CardForm.t,
  }

  @enforce_keys [
    :request_header,
    :register_alias,
    :type,
    :return_urls,
  ]
  defstruct @enforce_keys ++ [
    :styling,
    :language_code,
    :check,
    :payment_methods,
    :card_form,
  ]

  def new(attrs), do: struct!(__MODULE__, attrs)

  def generate(attrs) do
    %{
      request_header: Request.RequestHeader.generate(),
    }
    |> Map.merge(attrs)
    |> new
  end
end
