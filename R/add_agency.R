#' @title Add a transit agency to the GTFS
#' @name add_agency
#'
#' @description Add agency information (name, URL, time zone).
#'
#' @param name Agency name
#' @param url Agency URL link
#' @param timezone Agency time zone
#'
#' @return Adds a new row to the \code{Agency} object corresponding to the new agency's information.
#' @export
#'
#' @examples
#' add_agency(name = "Transport Montpellier TAM",
#'            url = "www.tam-voyages.com/",
#'            timezone = "Europe/Paris")
add_agency <- function(name,
                       url,
                       timezone) {

  agency <- globalenv()$agency

  new_row <- data.frame(agency_name = name,
                        agency_url = url,
                        agency_timezone = timezone)

  agency <<- rbind(agency,
                   new_row)
}
