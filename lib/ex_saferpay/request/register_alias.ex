defmodule ExSaferpay.Request.RegisterAlias do
  @moduledoc """
  RegisterAlias
  """

  use ExSaferpay.RequestNormalizer

  @type id_generator :: :manual |
    :random |
    :random_unique

  @type t :: %__MODULE__{
    id_generator: id_generator,
    id: nil | String.t,
    lifetime: 1..1600,
  }

  @enforce_keys [
    :id_generator,
  ]
  defstruct @enforce_keys ++ [
    :id,
    :lifetime,
  ]
end
