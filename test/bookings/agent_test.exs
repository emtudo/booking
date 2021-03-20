defmodule Booking.Bookings.AgentTest do
  use ExUnit.Case
  alias Booking.Bookings.Agent, as: BookingAgent
  use Agent

  import Booking.Factory

  describe "save/1" do
    setup do
      BookingAgent.start_link()

      :ok
    end

    test "saves the booking" do
      booking = build(:booking)

      assert BookingAgent.save(booking) == :ok
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link()

      :ok
    end

    test "when the booking is found, returns the booking" do
      booking = build(:booking)
      BookingAgent.save(booking)
      {:ok, response} = BookingAgent.get(booking.id)
      assert response == booking
    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("teste")

      assert response == {:error, "Flight Booking not found"}
    end
  end
end
