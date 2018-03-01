defmodule ExSaferpay.Response.Address do
  @moduledoc """
  See `Address` http://saferpay.github.io/jsonapi/1.2/
  """

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
          company: nil | String.t(),
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

  defstruct [
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

  def empty do
    %__MODULE__{
      date_of_birth: Date
    }
  end
end
