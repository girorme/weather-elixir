defmodule App.Weather do

  @api "http://api.openweathermap.org/data/2.5/weather?q="
  @api_key "YOUR_API_KEY"
  @kelvin_subtract 273.15

  def get_appid() do
    @api_key
  end

  def get_endpoint(location) do
    location = URI.encode(location)
    "#{@api}#{location}&appid=#{get_appid()}"
  end

  def kelvin_to_celsius(kelvin) do
    (kelvin - @kelvin_subtract) |> Float.round(1)
  end

  def temperature_of(location) do
    result = get_endpoint(location) |> HTTPoison.get |> parse_response
    case result do
      {:ok, temp} ->
        "#{location}: #{temp} graus Celsius"
      :error ->
        "#{location} not found"
    end
  end

  def start(cities) do
    cities
    |> Enum.map(&create_task/1)
    |> Enum.map(&Task.await/1)
  end

  defp create_task(city) do
    Task.async(fn -> temperature_of(city) end)
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: _}}) do
    body |> JSON.decode |> compute_temperature
  end

  defp compute_temperature(json) do
    try do
      {_, list} = json
      temp = list["main"]["temp"] |> kelvin_to_celsius
      {:ok, temp}
    rescue
      _ -> :error
    catch
      value ->
        IO.puts "Caught #{inspect(value)}"
    end
  end
end
