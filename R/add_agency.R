#' @title Add a transit agency to the GTFS
#' @name add_agency
#'
#' @description Add agency information (name, URL, time zone).
#'
#' @param agency_name Agency name
#' @param agency_url Agency URL link
#' @param agency_timezone Agency time zone
#'
#' @return Adds a new row to the \code{Agency} object corresponding to the new agency's information.
#' @export
#'
#' @examples
#' add_agency("TaM Montpellier", "blabla.com", "Paris/Europe")
add_agency <- function(agency_name, agency_url, agency_timezone) {

  agency <- globalenv()$agency

  new_row <- data.frame(agency_name = agency_name,
                        agency_url = agency_url,
                        agency_timezone = agency_timezone
                        )

  agency <<- rbind(agency, new_row)
}
