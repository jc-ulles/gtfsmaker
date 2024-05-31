#' @title Add a stop to the GTFS
#'
#' @description add a stop
#'
#' @param lat latitude of the location
#' @param lon longitude of the location
#' @param name name of the stop
#'
#' @return Add a new row to the `stops` object.
#' @export
#'
#' @examples
#'add_stops(lat = 43.59690,
#'          lon = 3.86357,
#'          name = "Parc Montcalm")
add_stops <- function(lat,
                      lon,
                      name) {

  stops <- as.data.frame(globalenv()$stops)

  if (nrow(stops) == 0) {
    new_stop_id <- 1
  } else {
    new_stop_id <- max(stops$stop_id) + 1
    }

    new_row <- data.frame(stop_id = new_stop_id,
                          stop_lat = lat,
                          stop_lon = lon,
                          stop_name = name)

    stops <<- rbind(stops,
                    new_row)
}

