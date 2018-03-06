defmodule ExSaferpay.Request.RequestHeader do
  @moduledoc """
  See `RequestHeader` http://saferpay.github.io/jsonapi/1.2/
  """

  use ExSaferpay.RequestNormalizer

  alias ExSaferpay.Util

  @type t :: %__MODULE__{
          spec_version: String.t(),
          customer_id: non_neg_integer,
          request_id: binary,
          retry_indicator: non_neg_integer
        }

  @enforce_keys [
    :spec_version,
    :customer_id,
    :request_id,
    :retry_indicator
  ]
  defstruct @enforce_keys

  def generate(retry_indicator \\ 0) do
    %__MODULE__{
      spec_version: ExSaferpay.spec_version(),
      customer_id: Util.customer_id(),
      request_id: UUID.uuid4(),
      retry_indicator: retry_indicator
    }
  end
end
