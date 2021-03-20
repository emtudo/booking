defmodule Booking.Bookings.BookingTest do
  use ExUnit.Case
  alias Booking.Bookings.Booking, as: Agenda
  import Booking.Factory

  describe "build/3" do
    test "when all params are valid, returns the booking" do
      user = build(:user)
      booking = build(:booking, id_usuario: user.id)

      {:ok, response} =
        Agenda.build(
          user.id,
          booking.data_completa,
          booking.cidade_origem,
          booking.cidade_destino
        )

      response =
        response
        |> Map.from_struct()
        |> Map.delete(:id)

      expected_response =
        booking
        |> Map.from_struct()
        |> Map.delete(:id)

      assert expected_response == response
    end

    test "when data_completa is invalid, returns an error" do
      user = build(:user)
      booking = build(:booking, id_usuario: user.id)

      response =
        Agenda.build(
          user.id,
          "teste",
          booking.cidade_origem,
          booking.cidade_destino
        )

      expected_response = {:error, "data_completa is invalid"}

      assert expected_response == response
    end
  end
end
