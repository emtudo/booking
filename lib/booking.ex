defmodule Booking do
  alias Booking.Bookings.Agent, as: BookingAgent
  alias Booking.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Booking.Bookings.GenerateReport
  alias Booking.Users.Agent, as: UserAgent
  alias Booking.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents() do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate get_user(user_id), to: UserAgent, as: :get
  defdelegate create_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_booking(user_id, params), to: CreateOrUpdateBooking, as: :call
  defdelegate get_booking(booking_id), to: BookingAgent, as: :get
  defdelegate generate_report(from_date, to_date), to: GenerateReport, as: :create
end
