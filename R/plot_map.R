#' @title Plot a map
#' @name plot_map
#'
#' @param route_id Identification of the route
#'
#' @return A leaflet map
#' @export
#'
#' @importFrom dplyr inner_join %>% filter summarise arrange
#' @importFrom sf st_cast st_combine st_as_sf
#' @importFrom leaflet %>% addTiles addCircles addPolylines leaflet
#'
#' @examples
#' \dontrun{
#' plot_map(route_id = 1)
#' }
plot_map <- function(route_id) {

  trips <- as.data.frame(globalenv()$trips)
  stop_times <- as.data.frame(globalenv()$stop_times)
  stops <- as.data.frame(globalenv()$stops)
  routes <- as.data.frame(globalenv()$routes)

  select <- route_id

  select_stop_times <- trips %>%
    inner_join(routes,by = "route_id") %>%
    inner_join(stop_times, by = "trip_id") %>%
    filter(route_id == select, trip_id == 1) %>%
    inner_join(stops, by = "stop_id")

  select_stop_times <- st_as_sf(select_stop_times,
                                coords = c("stop_lon", "stop_lat"),
                                crs = 4326)

  line <- select_stop_times %>%
    arrange(stop_sequence) %>%
    st_as_sf(crs = 4326) %>%
    summarise(route_long_name = unique(route_long_name),
              geometry = st_cast(st_combine(geometry), "LINESTRING"))

  map <- leaflet(select_stop_times) %>%
    addTiles() %>%
    addPolylines(data = line,
                 color = "red",
                 weight = 3,
                 opacity = 1,
                 popup = ~route_long_name) %>%
    addCircles(popup = ~stop_name,
               radius = 30,
               fillOpacity = 1,
               opacity = 1)

  return(map)
}
