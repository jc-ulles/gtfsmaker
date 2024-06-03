#' @title Plot transport offer
#' @name plot_trips
#'
#' @description Plot transport offer
#'
#' @param route_id identification number of the route concerned
#' @param size_point numerical value of the point size
#' @param size_line numerical value of the line size
#'
#' @return Create a graph of the transport offer
#' @export
#'
#' @importFrom ggplot2 ggplot theme_minimal scale_x_datetime geom_point geom_line labs aes theme element_blank scale_y_discrete scale_color_manual
#' @importFrom dplyr filter select slice summarize %>% pull arrange group_by ungroup mutate
#'
#' @examples
#' plot_trips(route_id = 1,
#' size_point = 1.4,
#' size_line = 0.8)
plot_trips <- function(route_id,
                       size_point,
                       size_line) {

  trips <- as.data.frame(globalenv()$trips)
  stops <- as.data.frame(globalenv()$stops)
  stop_times <- as.data.frame(globalenv()$stop_times)
  routes <- as.data.frame(globalenv()$routes)

  route_number <- route_id

  if (!("stop_id" %in% colnames(stop_times))) {
    message("Error: No column in stop_times is called stop_id")
    return(invisible())
  }

  if (!("stop_id" %in% colnames(stops))) {
    message("Error: No column in stops is called stop_id")
    return(invisible())
  }

  if (!("trip_id" %in% colnames(trips))) {
    message("Error: No column in trips is called trip_id")
    return(invisible())
  }

  jointure <- merge(stops,
                    stop_times,
                    by = "stop_id")
  jointure <- merge(jointure,
                    trips,
                    by = "trip_id")

  jointure <- jointure %>%
    filter(route_id == route_number)

  trips <- merge(trips,
                 routes,
                 by = "route_id")

  result <- trips %>%
    filter(route_id == route_number) %>%
    select(route_long_name) %>%
    slice(1)

  unique_trip_ids <- unique(jointure$trip_id)

  time_range <- stop_times %>%
    summarize(min_time = min(departure_time, na.rm = TRUE),
              max_time = max(departure_time, na.rm = TRUE))

  time_difference <- difftime(time_range$max_time,
                              time_range$min_time,
                              units = "mins")

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
    scale_x_datetime(date_breaks = temps_plot,
                     date_labels = "%H:%M")

  stop_name_levels <- jointure %>%
    group_by(trip_id) %>%
    arrange(stop_sequence, .by_group = TRUE) %>%
    pull(stop_name) %>%
    unique()

  data <- jointure %>%
    arrange(trip_id, stop_sequence) %>%
    group_by(trip_id) %>%
    summarize(stop_sequence_str = paste(stop_name, collapse = " => ")) %>%
    ungroup()

  data <- data %>%
    mutate(direction_id = as.integer(factor(stop_sequence_str)))

  jointure <- merge(jointure, data, by = "trip_id")

  unique_directions <- unique(data$direction_id)
  colors <- rainbow(length(unique_directions))
  names(colors) <- unique(data$direction_id)

  if(length(colors) == 1) {
    colors <- "#000000"
  }

  direction_labels <- setNames(data$stop_sequence_str, data$direction_id)


  for (i in 1:length(unique_trip_ids)) {

        trip_data <- subset(jointure,
                            trip_id == unique_trip_ids[i])

    p <- p + geom_point(data = trip_data,
                        aes(x = arrival_time, y = stop_name, group = 1, color = as.factor(direction_id)), size = size_point)

    p <- p + geom_line(data = trip_data,
                       aes(x = arrival_time, y = stop_name, group = 1, color = as.factor(direction_id)), size = size_line)
  }

  p <- p +
    scale_y_discrete(limits = stop_name_levels) +
    scale_color_manual(values = colors, labels = direction_labels, name = NULL) +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "bottom") +
    labs(title = "Plot of the transport offer",
         subtitle = paste("Route", result$route_long_name))

  return(p)
}
