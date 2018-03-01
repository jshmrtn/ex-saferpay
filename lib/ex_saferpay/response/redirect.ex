defmodule ExSaferpay.Response.Redirect do
  @moduledoc """
  See `Redirect` http://saferpay.github.io/jsonapi/1.8/
  """

  @type t :: %__MODULE__{
          redirect_url: String.t(),
          payment_means_required: boolean
        }

  defstruct [
    :redirect_url,
    :payment_means_required
  ]

  def empty do
    %__MODULE__{}
  end
end
