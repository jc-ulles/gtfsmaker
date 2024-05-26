#' @title Add a trip to the GTFS
#'
#' @description add a trip
#'
#' @param route_id identification number of the route concerned
#'
#' @return Add a new row to the `trips` object.
#' @export
#'
#' @examples
#' add_trips(1)
add_trips <- function(route_id) {

  trips <- as.data.frame(globalenv()$trips)

  if (exists("trips") && nrow(trips) > 0) {
    new_service_id <- max(trips$service_id) + 1 # Pas forcément un incrément, il peut y en avoir plusieurs
  } else {
    new_service_id <- 1
  }
  if (exists("trips") && nrow(trips) > 0) {
    new_trip_id <- max(trips$trip_id) + 1
  } else {
    new_trip_id <- 1
  }

  new_row <- data.frame(route_id = route_id,
                        service_id = new_service_id,
                        trip_id = new_trip_id
                        )

  trips <<- rbind(trips, new_row)
}
