defmodule TZS.Coordinate do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset

  schema "coordinates" do
    field(:latitude, :float)
    field(:longitude, :float)
  end

  def changeset(coordinate, params) do
    %TZS.Coordinate{}
    |> cast(params, [:latitude, :longitude])
    |> validate_required([:latitude, :longitude])
    |> validate_number(
      :latitude,
      greater_than: -90,
      less_than: 90,
      message: "-90 < latitude < 90"
    )
    |> validate_number(
      :longitude,
      greater_than_or_equal_to: -180,
      less_than_or_equal_to: 180,
      message: "-l80 <= longitude <= 180"
    )
  end
end
