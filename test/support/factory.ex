defmodule Booking.Factory do
  use ExMachina
  alias Booking.Users.User
  alias Booking.Bookings.Booking

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Leandro",
      email: "emtudo@gmail.com",
      cpf: "12345678901"
    }
  end

  def booking_factory do
    {:ok, date_time} = Timex.parse("2021-12-19 18:15", "{YYYY}-{0M}-{0D} {h24}:{m}")

    %Booking{
      id: UUID.uuid4(),
      id_usuario: UUID.uuid4(),
      data_completa: date_time,
      cidade_origem: "Curitiba",
      cidade_destino: "Uberaba"
    }
  end
end
