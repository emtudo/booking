defmodule Booking.Bookings.Agent do
  alias Booking.Bookings.Booking
  use Agent

  def start_link(state \\ %{}) do
    Agent.start_link(fn -> state end, name: __MODULE__)
  end

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  def get_by(from_date, to_date) do
    Agent.get(__MODULE__, &get_bookings(&1, from_date, to_date))
  end

  defp update_state(state, %Booking{id: id} = booking),
    do: Map.put(state, id, booking)

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp get_bookings(state, from_date, to_date) do
    with {:ok, from} <- Timex.parse(from_date, "{YYYY}-{0M}-{0D}"),
         {:ok, to} <- Timex.parse("#{to_date} 23:59:59", "{YYYY}-{0M}-{0D} {h24}:{m}:{s}") do
      Enum.reduce(state, %{}, &compare_dates(&1, &2, from, to))
    end
  end

  defp compare_dates({_, %Booking{} = booking}, acc, from_date, to_date) do
    case NaiveDateTime.compare(booking.data_completa, from_date) do
      :lt ->
        acc

      _ ->
        case NaiveDateTime.compare(booking.data_completa, to_date) do
          :gt -> acc
          _ -> Map.put(acc, booking.id, booking)
        end
    end
  end
end
