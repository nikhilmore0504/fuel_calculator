# FuelCalculator

The goal of this application is to calculate fuel to launch from one planet of the Solar system, and to land on another planet of the Solar system, depending on the flight route. Formula to calculate fuel is quite simple, but it depends on the planet's gravity. Planets NASA is interested in are:
- Earth - 9.807 m/s 2
- Moon - 1.62 m/s 2
- Mars - 3.711 m/s 2

The formula for fuel calculations for the launch is the following:mass * gravity * 0.042 - 33 rounded down
The formula for fuel calculations for the landing is the following:
mass * gravity * 0.033 - 42 rounded down

## Installation

Download this repository into a folder. Change directory into the code folder.
Now execute 
  $ iex -S mix

Now you can call the functions from the `iex> `prompt

