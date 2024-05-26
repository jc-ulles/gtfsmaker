#' @title Add a stop to the GTFS
#'
#' @description add a stop
#'
#' @param stop_lat latitude of the location
#' @param stop_lon longitude of the location
#' @param stop_name name of the stop
#'
#' @return Add a new row to the `stops` object.
#' @export
#'
#' @examples
#' add_stops(43.59608069974394, 3.8626826404232526, "Parc Montcalm")
add_stops <- function(stop_lat, stop_lon, stop_name) {

  stops <- as.data.frame(globalenv()$stops)

  if (nrow(stops) == 0) {
    new_stop_id <- 1
  } else {
    new_stop_id <- max(stops$stop_id) + 1
    }

    new_row <- data.frame(stop_id = new_stop_id,
                          stop_lat = stop_lat,
                          stop_lon = stop_lon,
                          stop_name = stop_name
                          )

    stops <<- rbind(stops, new_row)
}

