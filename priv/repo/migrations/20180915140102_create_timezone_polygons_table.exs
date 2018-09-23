defmodule Tashkent.Repo.Migrations.CreateTimezonePolygonsTable do
  use Ecto.Migration

  def up do
    create table(:timezone_polygons, primary_key: false) do
      add(:gid, :serial, primary_key: true)
      add(:tzid, :string, size: 80)
    end
    execute("SELECT AddGeometryColumn ('timezone_polygons', 'polygon', 4326, 'MULTIPOLYGON', 2);")
    create(index(:timezone_polygons, [:polygon], using: :gist))
  end

  def down do
    drop table(:timezone_polygons)
  end
end
