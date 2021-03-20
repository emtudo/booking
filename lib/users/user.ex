defmodule Booking.Users.User do
  @force_keys [:name, :email, :cpf]
  @keys @force_keys ++ [:id]

  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       name: name,
       email: email,
       cpf: cpf
     }}
  end
end
