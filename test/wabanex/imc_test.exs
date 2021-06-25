defmodule Wabanex.IMCTest do
	use ExUnit.Case, async: true

	alias Wabanex.IMC

	describe "calculate/1" do
		test "when the file exists, return the data" do
			params = %{"filename" => "students.csv"}

			response = IMC.calculate(params)

			expected_response = {:ok, %{"Gabriel" => 26.82742078020452}}

			assert expected_response == response
		end

		test "when the wrong filename is given, returns an error" do
			params = %{"filename" => "dio.csv"}

			response = IMC.calculate(params)

			expected_response = {:error, "error while opening the file"}

			assert expected_response == response
		end
	end
end
