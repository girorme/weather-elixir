# Weather elixir

Simple async weather info using elixir

## Installation

```bash
$ mix deps.get
```

## Usage
- Create an account and get an api key on: https://openweathermap.org/

- Change the key on `lib/app/weather.ex::@api_key`
- Start :)

### One by one:
```bash
$ iex -S mix
Interactive Elixir (1.8.2) - press Ctrl+C to exit (type h() ENTER for help)

iex(1)> App.Weather.temperature_of("Rio de Janeiro")
"Rio de Janeiro: 19.3 graus Celsius"

iex(2)> App.Weather.temperature_of("Sao Paulo")
"Sao Paulo: 19.2 graus Celsius"
```

### Async
```bash
iex(3)> cities = ["Rio de Janeiro", "Sao Paulo", "Porto Alegre"]

iex(4)> App.Weather.start(cities)
["Rio de Janeiro: 19.3 graus Celsius", "Sao Paulo: 19.2 graus Celsius",
 "Porto Alegre: 18.1 graus Celsius"]
```

Tests
```bash
$ mix test
Compiling 1 file (.ex)
......

Finished in 1.0 seconds
1 doctest, 5 tests, 0 failures

Randomized with seed 458000
```
