defmodule Booking.Bookings.GenerateReport do
  alias Booking.Bookings.Agent, as: BookingAgent
  alias Booking.Bookings.Booking, as: Agenda

  def create(from_date, to_date) do
    bookings =
      BookingAgent.get_by(from_date, to_date)
      |> Enum.map(&booking_to_string(&1))

    File.write("report.csv", bookings)
    {:ok, "Report generated successfully"}
  end

  defp booking_to_string(
         {_id,
          %Agenda{
            id_usuario: id_usuario,
            data_completa: data_completa,
            cidade_origem: cidade_origem,
            cidade_destino: cidade_destino
          }}
       ) do
    "#{id_usuario},#{cidade_origem},#{cidade_destino},#{data_completa}\n"
  end
end
