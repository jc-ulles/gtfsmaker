#' @title Add a trip to the GTFS
#'
#' @description add a trip
#'
#' @param route_id identification number of the route concerned
#' @param service_id identification number of the service concerned
#'
#' @return Add a new row to the `trips` object.
#' @export
#'
#' @examples
#' add_trips(route_id = 1,
#'           service_id = 1)
add_trips <- function(route_id,
                      service_id) {

  trips <- as.data.frame(globalenv()$trips)

  if (exists("trips") && nrow(trips) > 0) {
    new_trip_id <- max(trips$trip_id) + 1
  } else {
    new_trip_id <- 1
  }

  new_row <- data.frame(route_id = route_id,
                        service_id = service_id,
                        trip_id = new_trip_id)

  trips <<- rbind(trips,
                  new_row)
}
