defmodule FuelCalculator do
  @moduledoc """
  The goal of this application is to calculate fuel required to launch vehicle
  from one planet of the Solar system, and to land on another planet of the
  Solar system.
  """

  @doc """
  Calculate fuel requirements for the given mass of the space craft and the
  route details.

  ## Examples

      iex> FuelCalculator.calculate_fuel(28801,
      ...>  [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62},
      ...>   {:land, 9.807}])
      51898

  """
  @spec calculate_fuel(number(), [{:atom, number()}]) :: number() | {:error, any()}
  def calculate_fuel(mass, actions) do
    case is_number(mass) do
      true ->
        actions
        |> Enum.reverse()
        |> Enum.reduce(0, fn action, acc ->
          project_fuel(mass + acc, action) + acc
        end)

      false ->
        {:error, "numeric_mass_expected"}
    end
  end

  @doc """
  Calculate fuel requirements for the given mass of the space craft and the
  route details.

  ## Examples

      iex> FuelCalculator.project_fuel(28801, {:land, 9.807})
      13447

      iex> FuelCalculator.project_fuel(28801, {:launch, 9.807})
      19772

  """
  def project_fuel(mass, {:land, gravity}) do
    try do
      calculate_landing_fuel(mass, gravity, 0)
    rescue
      ArithmeticError ->
        {:error, "either_mass_or_gravity_is_non_numeric"}
    end
  end

  def project_fuel(mass, {:launch, gravity}) do
    try do
      calculate_launching_fuel(mass, gravity, 0)
    rescue
      ArithmeticError ->
        {:error, "either_mass_or_gravity_is_non_numeric"}
    end
  end

  def project_fuel(_mass, {_other_key, _gravity}) do
    {:error, "invalid_action"}
  end

  defp calculate_launching_fuel(mass, gravity, fuel_quantity) do
    additional_fuel = floor(mass * gravity * 0.042) - 33

    case additional_fuel <= 0 do
      true -> fuel_quantity
      _ -> calculate_launching_fuel(additional_fuel, gravity, fuel_quantity + additional_fuel)
    end
  end

  defp calculate_landing_fuel(mass, gravity, fuel_quantity) do
    additional_fuel = floor(mass * gravity * 0.033) - 42

    case additional_fuel <= 0 do
      true -> fuel_quantity
      _ -> calculate_landing_fuel(additional_fuel, gravity, fuel_quantity + additional_fuel)
    end
  end
end
