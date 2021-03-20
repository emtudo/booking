defmodule Booking.Bookings.Booking do
  @force_keys [:data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @keys @force_keys ++ [:id]

  @enforce_keys @force_keys

  defstruct @keys

  def build(
        id_usuario,
        %NaiveDateTime{} = data_completa,
        cidade_origem,
        cidade_destino
      ) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       id_usuario: id_usuario,
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino
     }}
  end

  def build(
        _id_usuario,
        _,
        _cidade_origem,
        _cidade_destino
      ) do
    {:error, "data_completa is invalid"}
  end
end
