defmodule Booking.Bookings.GenerateReportTest do
  use ExUnit.Case
  alias Booking.Bookings.Agent, as: BookingAgent
  alias Booking.Bookings.GenerateReport
  use Agent

  import Booking.Factory

  describe "generate_report/2" do
    setup do
      BookingAgent.start_link()

      :ok
    end

    test "generate report from dates" do
      :booking |> build(data_completa: ~N[2021-12-19 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-20 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-21 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-29 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-30 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-31 00:00:00]) |> BookingAgent.save()

      :booking |> build(data_completa: ~N[2021-12-22 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-23 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-24 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-25 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-26 00:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-27 23:59:59]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-28 01:00:00]) |> BookingAgent.save()
      :booking |> build(data_completa: ~N[2021-12-28 23:53:53]) |> BookingAgent.save()

      File.rm("report.csv")

      response = GenerateReport.create("2021-12-25", "2021-12-28")

      expected_response = {:ok, "Report generated successfully"}


      assert expected_response == response

      assert File.exists?("report.csv")
    end
  end
end
