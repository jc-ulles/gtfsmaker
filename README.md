
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gtfsmaker

<!-- badges: start -->

[![R-CMD-check](https://github.com/jc-ulles/gtfsmaker/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jc-ulles/gtfsmaker/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

Create your own GTFS. This package aims to build a functional GTFS from
scratch by adding your own transport offer data. The functions are
designed to automate and simplify the process of adding data to the
files that make up the GTFS. The new GTFS produced can be saved and used
in `opentripplanner`.

## Installation

You can install the development version of gtfsmaker from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jc-ulles/gtfsmaker")
```

## How the GTFS works

## Example

An example of creating a GTFS from fictitious data:

``` r
library(gtfsmaker )

# Create all the files needed in the R environment
gtfs_files()

# Add a new transport agency
add_agency("Transport Montpellier TAM", "www.tam-voyages.com/", "Europe/Paris")

# Add some stops with location
add_stops(43.59608069974394, 3.8626826404232526, "Parc Montcalm")
add_stops(43.59608069974394, 4.8626826404232526, "Gare")
add_stops(43.59608069974394, 4.8626826404232526, "Eloi")

# Add a new route: long name and mode of transport (0 is for the tram)
add_route("Montcalm - Lunaret", 0)

# Add a new trip belonging to a route (1 is for the route_id created when the route was added previously)
add_trips(1)

# Add some transport services corresponding to a trip (trip_id), a timetable, a stop (stop_id) and the order of progression in the sequence
add_stop_times(1, "05:00:00", 1, 1)
add_stop_times(1, "05:20:00", 2, 2)
add_stop_times(1, "05:28:00", 3, 3)

# Repeat the sequence of the selected transport service (trip_id) up to a maximum time, following a defined time step (in minutes)
repeat_stop_times(1, "23:00:00", 10)

# Add a calendar defining the days on which the service operates (Monday to Sunday) and the time slot
add_calendar(1, 1, 1, 1, 1, 1, 1, 1, 20240511, 20241231)

# Finally, plot the transport offer (trip_id)
plot_trips(1)
```

<img src="man/figures/README-example-1.png" width="100%" />
