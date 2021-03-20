defmodule Booking.Bookings.CreateOrUpdateTest do
  use ExUnit.Case
  alias Booking.Bookings.Agent, as: BookingAgent
  alias Booking.Bookings.CreateOrUpdate
  alias Booking.Users.Agent, as: UserAgent
  import Booking.Factory

  describe "call/2" do
    setup do
      Booking.start_agents()

      user = build(:user)
      UserAgent.save(user)

      booking =
        build(:booking)
        |> Map.from_struct()
        |> Map.delete(:id)

      {:ok, user_id: user.id, booking: booking}
    end

    test "when all params are valid, saves the booking id", %{user_id: user_id, booking: booking} do
      params = %{
        data_completa: NaiveDateTime.to_string(booking.data_completa),
        cidade_origem: booking.cidade_origem,
        cidade_destino: booking.cidade_destino
      }

      response =
        CreateOrUpdate.call(
          user_id,
          params
        )

      assert {:ok, _booking_id} = response
    end

    test "when user is not found, returns an error", %{booking: booking} do
      params = %{
        data_completa: NaiveDateTime.to_string(booking.data_completa),
        cidade_origem: booking.cidade_origem,
        cidade_destino: booking.cidade_destino
      }

      response =
        CreateOrUpdate.call(
          "teste",
          params
        )

      assert {:error, "User not found"} = response
    end
  end
end
