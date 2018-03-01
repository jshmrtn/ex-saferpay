defmodule ExSaferpay.Response.Error do
  @moduledoc """
  See `Error` http://saferpay.github.io/jsonapi/1.2/
  """

  @type t :: %__MODULE__{
          error_name: nil | String.t(),
          error_message: nil | String.t()
        }

  defstruct [
    :error_name,
    :error_message
  ]

  def empty do
    %__MODULE__{}
  end
end
