defmodule ExSaferpay.Response.ResponseHeader do
  @moduledoc """
  See `ResponseHeader` http://saferpay.github.io/jsonapi/1.2/
  """

  @type t :: %__MODULE__{
          spec_version: String.t(),
          request_id: binary
        }

  defstruct [
    :spec_version,
    :request_id
  ]

  def empty do
    %__MODULE__{}
  end
end
