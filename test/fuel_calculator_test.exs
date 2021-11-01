defmodule FuelCalculatorTest do
  use ExUnit.Case
  doctest FuelCalculator

  describe "calculate_fuel" do
    test "returns correct values" do
      assert FuelCalculator.calculate_fuel(28_801, [
               {:launch, 9.807},
               {:land, 1.62},
               {:launch, 1.62},
               {:land, 9.807}
             ]) == 51_898

      assert FuelCalculator.calculate_fuel(14_606.0, [
               {:launch, 9.807},
               {:land, 3.711},
               {:launch, 3.711},
               {:land, 9.807}
             ]) == 33_388

      assert FuelCalculator.calculate_fuel(75_432, [
               {:launch, 9.807},
               {:land, 1.62},
               {:launch, 1.62},
               {:land, 3.711},
               {:launch, 3.711},
               {:land, 9.807}
             ]) == 212_161
    end

    test "non numerical mass values returns {:error, \"numeric_mass_expected\"}" do
      assert FuelCalculator.calculate_fuel("not_a_number", [{:launch, 9.807}]) ==
               {:error, "numeric_mass_expected"}
    end
  end

  describe "project_fuel" do
    test "returns expected values" do
      assert FuelCalculator.project_fuel(28_801, {:land, 9.807}) == 13_447
      assert FuelCalculator.project_fuel(28_801, {:launch, 9.807}) == 19_772
    end

    test "return error on invalid action" do
      assert FuelCalculator.project_fuel(28_801, {:not_a_valid_key, 9.807}) ==
               {:error, "invalid_action"}
    end

    test "mass or gravity non-numeric" do
      assert FuelCalculator.project_fuel("28801", {:launch, 9.807}) ==
               {:error, "either_mass_or_gravity_is_non_numeric"}

      assert FuelCalculator.project_fuel(28_801, {:launch, "9.807"}) ==
               {:error, "either_mass_or_gravity_is_non_numeric"}
    end
  end
end
