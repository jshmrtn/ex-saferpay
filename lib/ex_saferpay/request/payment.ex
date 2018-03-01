defmodule ExSaferpay.Request.Payment do
  @moduledoc """
  Request Body for Payment
  """

  use ExSaferpay.RequestNormalizer
  alias ExSaferpay.Request

  @type t :: %__MODULE__{
          amount: Request.Amount.t(),
          order_id: nil | String.t(),
          description: nil | String.t(),
          payer_note: nil | String.t(),
          mandate_id: nil | String.t(),
          options: nil | Request.Options.t(),
          recurring: nil | Request.Recurring.t(),
          installment: nil | Request.Installment.t()
        }

  @enforce_keys [
    :amount
  ]
  defstruct @enforce_keys ++
              [
                :order_id,
                :description,
                :payer_note,
                :mandate_id,
                :options,
                :recurring,
                :installment
              ]
end
