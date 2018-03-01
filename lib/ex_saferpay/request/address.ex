defmodule ExSaferpay.Request.Address do
  @moduledoc """
  Request Body for Address
  """

  use ExSaferpay.RequestNormalizer

  @type gender ::
          :male
          | :female
          | :company

  @type legal_form ::
          :ag
          | :gmbh
          | :misc

  @type t :: %__MODULE__{
          first_name: nil | String.t(),
          last_name: nil | String.t(),
          date_of_birth: nil | Date.t(),
          company: nil | Date.t(),
          gender: nil | gender,
          legal_form: nil | legal_form,
          street: nil | String.t(),
          street2: nil | String.t(),
          zip: nil | String.t(),
          city: nil | String.t(),
          country_subdivision_code: nil | String.t(),
          country_code: nil | String.t(),
          phone: nil | String.t(),
          email: nil | String.t()
        }

  @enforce_keys []
  defstruct @enforce_keys ++
              [
                :first_name,
                :last_name,
                :date_of_birth,
                :company,
                :gender,
                :legal_form,
                :street,
                :street2,
                :zip,
                :city,
                :country_subdivision_code,
                :country_code,
                :phone,
                :email
              ]
end
