#' @title Save the GTFS on disk
#' @name gtfs_save
#'
#' @description Save the .txt files on disk
#'
#' @param filename File name to create on disk
#'
#' @return Save six .txt files (agency, calendar, routes, stoptimes, stops, trips) on disk
#' @export
#'
#' @examples
#' \dontrun{
#' gtfs_save(filename = "C:/...")
#' }
gtfs_save <- function(filename) {

  agency <- as.data.frame(globalenv()$agency)
  calendar <- as.data.frame(globalenv()$calendar)
  routes <- as.data.frame(globalenv()$routes)
  stop_times <- as.data.frame(globalenv()$stop_times)
  stops <- as.data.frame(globalenv()$stops)
  trips <- as.data.frame(globalenv()$trips)

  # agency
  agency_no_quotes <- agency
  colnames(agency_no_quotes) <- gsub('"', '', colnames(agency_no_quotes))
  write.csv(agency_no_quotes, paste0(filename, "/agency.txt"), row.names = FALSE, quote = FALSE)

  # calendar
  calendar_no_quotes <- calendar
  colnames(calendar_no_quotes) <- gsub('"', '', colnames(calendar_no_quotes))
  write.csv(calendar_no_quotes, paste0(filename, "/calendar.txt"), row.names = FALSE, quote = FALSE)

  # routes
  routes_no_quotes <- routes
  colnames(routes_no_quotes) <- gsub('"', '', colnames(routes_no_quotes))
  write.csv(routes_no_quotes, paste0(filename, "/routes.txt"), row.names = FALSE, quote = FALSE)

  # stop_times
  if ("POSIXct" %in% class(stop_times$arrival_time)) {
    stop_times$arrival_time <- format(stop_times$arrival_time, "%H:%M:%S")
  }

  if ("POSIXct" %in% class(stop_times$departure_time)) {
    stop_times$departure_time <- format(stop_times$departure_time, "%H:%M:%S")
  }

  stop_times_no_quotes <- stop_times
  colnames(stop_times_no_quotes) <- gsub('"', '', colnames(stop_times_no_quotes))
  write.csv(stop_times_no_quotes, paste0(filename, "/stop_times.txt"), row.names = FALSE, quote = FALSE)

  # stops
  stops_no_quotes <- stops
  colnames(stops_no_quotes) <- gsub('"', '', colnames(stops_no_quotes))
  write.csv(stops_no_quotes, paste0(filename, "/stops.txt"), row.names = FALSE, quote = FALSE)

  # trips
  trips_no_quotes <- trips
  colnames(trips_no_quotes) <- gsub('"', '', colnames(trips_no_quotes))
  write.csv(trips_no_quotes, paste0(filename, "/trips.txt"), row.names = FALSE, quote = FALSE)
}
