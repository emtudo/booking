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

  describe "get_by/2" do
    setup do
      BookingAgent.start_link()
      :ok
    end

    test "get bookins from dates" do
      :booking |> build(data_completa: ~N[2021-12-19 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-20 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-21 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-29 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-30 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-31 00:00:00]) |> BookingAgent.save()

      booking1 = :booking |> build(data_completa: ~N[2021-12-22 00:00:00])
      booking2 = :booking |> build(data_completa: ~N[2021-12-23 00:00:00])
      booking3 = :booking |> build(data_completa: ~N[2021-12-24 00:00:00])
      booking4 = :booking |> build(data_completa: ~N[2021-12-25 00:00:00])
      booking5 = :booking |> build(data_completa: ~N[2021-12-26 00:00:00])
      booking6 = :booking |> build(data_completa: ~N[2021-12-27 23:59:59])
      booking7 = :booking |> build(data_completa: ~N[2021-12-28 01:00:00])
      booking8 = :booking |> build(data_completa: ~N[2021-12-28 23:53:53])

      BookingAgent.save(booking1)
      BookingAgent.save(booking2)
      BookingAgent.save(booking3)
      BookingAgent.save(booking4)
      BookingAgent.save(booking5)
      BookingAgent.save(booking6)
      BookingAgent.save(booking7)
      BookingAgent.save(booking8)

      response = BookingAgent.get_by("2021-12-22", "2021-12-28")

      expected_response = %{
        booking1.id => booking1,
        booking2.id => booking2,
        booking3.id => booking3,
        booking4.id => booking4,
        booking5.id => booking5,
        booking6.id => booking6,
        booking7.id => booking7,
        booking8.id => booking8
      }

      assert expected_response == response
    end
  end
end
