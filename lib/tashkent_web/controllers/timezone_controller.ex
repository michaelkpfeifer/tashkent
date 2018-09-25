defmodule TashkentWeb.TimezoneController do
  require Logger
  use TashkentWeb, :controller

  def lookup(conn, params) do
    changeset = Tashkent.Coordinate.changeset(%{}, params)

    case changeset do
      %{
        :changes => %{
          :latitude => latitude,
          :longitude => longitude
        },
        :valid? => true
      } ->
        coordinate_string = "POINT(#{longitude} #{latitude})"
        where_clause = "ST_Intersects(ST_GeomFromText(\'#{coordinate_string}\', 4326), polygon)"
        query = "SELECT tzid FROM timezone_polygons WHERE #{where_clause};"

        {:ok, result_set} = Ecto.Adapters.SQL.query(Tashkent.Repo, query, [])
        timezone_id = List.first(List.first(result_set.rows))

        conn
        |> json(%{timezoneId: timezone_id})

      _ ->
        error_map = %{
          validationErrors:
            Enum.into(
              changeset.errors,
              %{},
              fn {param, {message, _options}} -> {param, message} end
            )
        }

        conn
        |> put_status(400)
        |> json(error_map)
    end

    conn
    |> json(%{tzid: "Europe/Berlin"})
  end
end
