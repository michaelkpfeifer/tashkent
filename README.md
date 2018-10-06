# Tashkent - A Simple Timezone Server

## Introduction

Tashkent is a little web service that takes a latitude/longitude
coordinate and returns the time zone corresponding to the coordinate.

## Prerequisites

Tashkent is implemented as a Phoenix application. In order to run the
service, you need Elixir and Phoenix installed. Timezone data is
stored in a PostgreSQL database and the PostGIS extenstion must be
avaliable on your system.

## Installation

The following instructions explain how to get the development
environment up and running. Deployment and running production is out
of scope of the current document.

1. Clone the tashkent repository

2. Edit *config/dev.exs* to match your database configuration. You
   will probably need to change username and password. You may also
   want to change the port number to avoid conflicts on machines that
   run multiple services.

3. Get the Elixir dependencies required for running the application
   and compile them

    ```
    $ cd tashkent
    $ mix deps.get
    $ mix deps.compile
    ```

3. Create the development database

    ```
    $ mix ecto.create
    ```

4. Run the migrations

    ```
    $ mix ecto.migrate
    ```

    The first migration installs the PostGIS extension for the newly
    created database.

5. Download the timezone data

    ```
    $ wget https://github.com/evansiroky/timezone-boundary-builder/releases/download/2018d/timezones-with-oceans.shapefile.zip
    ```

    Depending on the speed of your internet connection, this may take
    some time. Note that the `wget` command above downloads the
    timezone data of the 2018d release. There may be later releases
    available.

6. Import the timezone data

    ```
    $ unzip timezones-with-oceans.shapefile.zip
    $ (cd dist; shp2pgsql -d -I -s 4326 -g polygon combined-shapefile-with-oceans.shp timezone_polygons | psql -U scratch -h localhost tashkent_dev)
    $ rm timezones-with-oceans.shapefile.zip
    $ rm -r dist
    ```

    Make sure that the options given to the `psql`command reflect your
    database settings. You will be asked for your database password
    when you start importing the data.

    Thanks to Evan Siroky for providing the timezone data,
    http://www.evansiroky.com, https://github.com/evansiroky,

## Test

So far, there are no automated tests. The following little procedure
should verify that things are working and that you get the answer you
expect.

1. Open a new terminal and run the Phoenix server

    ```
    $ mix phx.server
    ```

2. Create an http request

    ```
    $ curl --header "Content-Type: application/json" --request POST --data '{"latitude":"41.2995","longitude":"69.2401"}' http://localhost:4010/api/timezone/lookup
    ```

    Make sure the hostname is correct and the port matches your
    development configuration. This request should return
    `{"timezoneId":"Asia/Tashkent"}`.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/michaelkpfeifer/tashkent.

## License

This software is available under the terms of the MIT License.
