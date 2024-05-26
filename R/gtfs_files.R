#' @title Create all files needed for GTFS
#'
#' @description Create all files needed for GTFS
#'
#' @return Create empty objets: `agency`, `stops`, `routes`, `trips`, `stop_times` and `calendar`
#' @export
#'
#' @examples
#' gtfs_files()
gtfs_files <- function() {
  agency <- data.frame(agency_name = character(),
                       agency_url = character(),
                       agency_timezone = character()
  )
  assign("agency", agency, envir = .GlobalEnv)

  stops <- data.frame(stop_id = character(),
                      stop_lat = character(),
                      stop_lon = character(),
                      stop_name = character()
  )
  assign("stops", stops, envir = .GlobalEnv)

  routes <- data.frame(route_id = character(),
                       route_long_name = character(),
                       route_type = character()
  )
  assign("routes", routes, envir = .GlobalEnv)

  trips <- data.frame(route_id = character(),
                      service_id = character(),
                      trip_id = character()
  )
  assign("trips", trips, envir = .GlobalEnv)

  stop_times <- data.frame(trip_id = character(),
                           arrival_time = character(),
                           departure_time = character(),
                           stop_id = character(),
                           stop_sequence = character()
  )
  assign("stop_times", stop_times, envir = .GlobalEnv)

  calendar <- data.frame(service_id = character(),
                         monday = character(),
                         tuesday = character(),
                         wednesday = character(),
                         thursday = character(),
                         friday = character(),
                         saturday = character(),
                         sunday = character(),
                         start_date = character(),
                         end_date = character()
  )
  assign("calendar", calendar, envir = .GlobalEnv)
}
