defmodule ExSaferpay.Response.Card do
  @moduledoc """
  See `Card` http://saferpay.github.io/jsonapi/1.2/
  """

  @type t :: %__MODULE__{
          masked_number: String.t(),
          exp_year: non_neg_integer,
          exp_month: non_neg_integer,
          holder_name: nil | String.t(),
          country_code: nil | atom,
          hash_value: nil | String.t()
        }

  defstruct [
    :masked_number,
    :exp_year,
    :exp_month,
    :holder_name,
    :country_code,
    :hash_value
  ]

  def empty do
    %__MODULE__{
      country_code: :atom
    }
  end
end
