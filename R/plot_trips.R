#' @title Plot transport offer
#'
#' @description Plot transport offer
#'
#' @param service_id_v identification number of the service concerned
#'
#' @return Create a graph of the transport offer
#' @export
#'
#' @importFrom ggplot2 ggplot theme_minimal scale_x_datetime geom_point geom_line labs
#'
#' @examples
#' plot_trips(1)
plot_trips <- function(service_id_v) {

  trips <- as.data.frame(globalenv()$trips)
  stops <- as.data.frame(globalenv()$stops)
  stop_times <- as.data.frame(globalenv()$stop_times)

  if (!("stop_id" %in% colnames(stop_times))) {
    return("fin")
  }

  if (!("stop_id" %in% colnames(stops))) {
    return("fin")
  }

  if (!("trip_id" %in% colnames(trips))) {
    return("fin")
  }

  jointure <- merge(stops, stop_times, by = "stop_id")
  jointure <- merge(jointure, trips, by = "trip_id")

  jointure <- subset(jointure, service_id == service_id_v)

  unique_trip_ids <- unique(jointure$trip_id)

  p <- ggplot() + theme_minimal() + scale_x_datetime(date_breaks = "1 hour", date_labels = "%H:%M")

  for (i in 1:length(unique_trip_ids)) {

        trip_data <- subset(jointure, trip_id == unique_trip_ids[i])

    p <- p + geom_point(data = trip_data, aes(x = arrival_time, y = factor(stop_name, levels = unique(stop_name)), group = 1))

    p <- p + geom_line(data = trip_data, aes(x = arrival_time, y = factor(stop_name, levels = unique(stop_name)), group = 1))
  }

  p <- p + labs(x = "Temps", y = "Arrêts de transport", title = "Horaire d'arrivée des transports par arrêt")

  return(p)
}
