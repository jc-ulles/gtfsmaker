#' @title Plot transport offer
#'
#' @description Plot transport offer
#'
#' @param service_id identification number of the service concerned
#'
#' @return Create a graph of the transport offer
#' @export
#'
#' @importFrom ggplot2 ggplot theme_minimal scale_x_datetime geom_point geom_line labs aes theme element_blank
#' @importFrom dplyr filter select slice summarize %>%
#'
#' @examples
#' plot_trips(1)
plot_trips <- function(service_id) {

  trips <- as.data.frame(globalenv()$trips)
  stops <- as.data.frame(globalenv()$stops)
  stop_times <- as.data.frame(globalenv()$stop_times)
  routes <- as.data.frame(globalenv()$routes)

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

  jointure <- jointure %>%
    filter(service_id == service_id)

  trips <- merge(trips, routes, by = "route_id")

  result <- trips %>%
    filter(service_id == service_id) %>%
    select(route_long_name) %>%
    slice(1)

  unique_trip_ids <- unique(jointure$trip_id)

  time_range <- stop_times %>%
    summarize(min_time = min(departure_time, na.rm = TRUE),
              max_time = max(departure_time, na.rm = TRUE))

  time_difference <- difftime(time_range$max_time, time_range$min_time, units = "mins")

  if (time_difference < 60) {
    temps_plot <- "10 mins"
  }

  if (time_difference >= 60 & time_difference <= 480) {
    temps_plot <- "30 mins"
  }

  if (time_difference > 480) {
    temps_plot <- "1 hour"
  }


  p <- ggplot() +
    theme_minimal() +
    scale_x_datetime(date_breaks = temps_plot, date_labels = "%H:%M")

  for (i in 1:length(unique_trip_ids)) {

        trip_data <- subset(jointure, trip_id == unique_trip_ids[i])

    p <- p + geom_point(data = trip_data, aes(x = arrival_time, y = factor(stop_name, levels = unique(stop_name)), group = 1))

    p <- p + geom_line(data = trip_data, aes(x = arrival_time, y = factor(stop_name, levels = unique(stop_name)), group = 1))
  }

  p <- p +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank()) +
    labs(title = "Plot of the transport offer",
         subtitle = paste("Route", result$route_long_name))

  return(p)
}
