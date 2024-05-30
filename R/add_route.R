#' @title Add a route to the GTFS
#' @name add_route
#'
#' @description Add a new route
#'
#' @param name name of the route
#' @param type type of transportation used on a route:
#' * `0`: Tram, Streetcar, Light rail. Any light rail or street level system within a metropolitan area
#' * `1`: Subway, Metro. Any underground rail system within a metropolitan area
#' * `2`: Rail. Used for intercity or long-distance travel
#' * `3`: Bus. Used for short- and long-distance bus routes
#' * `4`: Ferry. Used for short- and long-distance boat service
#' * `5`: Cable tram. Used for street-level rail cars where the cable runs beneath the vehicle (e.g., cable car in San Francisco)
#' * `6`: Aerial lift, suspended cable car (e.g., gondola lift, aerial tramway). Cable transport where cabins, cars, gondolas or open chairs are suspended by means of one or more cables
#' * `7`: Funicular. Any rail system designed for steep inclines
#' * `11`: Trolleybus. Electric buses that draw power from overhead wires using poles
#' * `12`: Monorail. Railway in which the track consists of a single rail or a beam
#'
#' @return Add a new row to the `Routes` object corresponding to the new routes's information.
#' @export
#'
#' @examples
#' add_route("Montcalm - Lunaret", 0)
add_route <- function(name, type) {

  routes <- as.data.frame(globalenv()$routes)

  if (exists("routes") && nrow(routes) > 0) {
    new_route_id <- max(routes$route_id) + 1
  } else {
    new_route_id <- 1
  }

  new_row <- data.frame(route_id = new_route_id,
                        route_long_name = name,
                        route_type = type
                        )

  routes <<- rbind(routes, new_row)
}
