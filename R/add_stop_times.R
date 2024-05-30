#' @title Add trip information to the GTFS
#'
#' @description add trip information (time, stop, sequence) to stop_times
#'
#' @param trip_id identification number of the trip concerned
#' @param time time "HH:MM:SS" at the stop for the specific trip
#' @param stop_id identification number of the stop concerned
#' @param sequence stop order number for the trip concerned
#'
#' @return Add a new row to the `stop_times` object.
#' @export
#'
#' @examples
#' add_stop_times(1, "05:00:00", 1, 1)
add_stop_times <- function(trip_id, time, stop_id, sequence) {

  stop_times <- globalenv()$stop_times
  trips <- globalenv()$trips
  stops <- globalenv()$stops

  trip_number <- trip_id

  if (!(trip_id %in% trips$trip_id)) {
    message("Erreur: trip_id '", trip_id, "' n'existe pas dans trips$trip_id")
    return(invisible())
  }

  if (!(stop_id %in% stops$stop_id)) {
    message("Erreur: stop_id '", stop_id, "' n'existe pas dans stops$stop_id")
    return(invisible())
  }

  if_test <- stop_times %>%
    filter(trip_id == trip_number)

  if (sequence %in% if_test$stop_sequence) {
    message("Erreur: stop_sequence '", sequence, "' existe deja dans stop_times$stop_sequence")
    return(invisible())
  }

  new_row <- data.frame(trip_id = trip_id,
                        arrival_time = time,
                        departure_time = time,
                        stop_id = stop_id,
                        stop_sequence = sequence
                        )

  new_row$arrival_time <- as.POSIXct(new_row$arrival_time, format = "%H:%M:%S")
  new_row$departure_time <- as.POSIXct(new_row$departure_time, format = "%H:%M:%S")

  stop_times <<- rbind(stop_times, new_row)
}
