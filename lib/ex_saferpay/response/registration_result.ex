defmodule ExSaferpay.Response.RegistrationResult do
  @moduledoc """
  See `RegistrationResult` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
          success: boolean,
          alias: nil | Response.Alias.t(),
          error: nil | Response.Error.t()
        }

  defstruct [
    :success,
    :alias,
    :error
  ]

  def empty do
    %__MODULE__{
      alias: Response.Alias.empty(),
      error: Response.Error.empty()
    }
  end
end
