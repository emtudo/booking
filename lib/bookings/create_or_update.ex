defmodule Booking.Bookings.CreateOrUpdate do
  alias Booking.Users.User
  alias Booking.Users.Agent, as: UserAgent
  alias Booking.Bookings.Agent, as: BookingAgent
  alias Booking.Bookings.Booking

  def call(id_usuario, %{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino
      }) do

    id_usuario
    |> parse_user()
    |> build(data_completa, cidade_origem, cidade_destino)
  end

  defp parse_user(user_id), do:  UserAgent.get(user_id)

  defp build({:ok, %User{} = user}, data_completa, cidade_origem, cidade_destino) do
    case parse_date_time(data_completa) do
      {:ok, date_time} ->
        user.id
          |> Booking.build(date_time, cidade_origem, cidade_destino)
          |> save_Booking()

      {:error, _reason} ->
        {:error, "Data inválida"}
    end
  end

  defp build({:error, _reason} = error, _data_completa, _cidade_origem, _cidade_destino), do: error

  defp save_Booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)

    {:ok, booking.id}
  end

  defp parse_date_time(date_time) do
    case Timex.parse(date_time, "{YYYY}-{0M}-{0D} {h24}:{m}") do
      {:ok, _date} = date -> date
      {:error, _reason} -> Timex.parse(date_time, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}")
    end
  end


  defp save_Booking({:error, _reason} = error), do: error
end
