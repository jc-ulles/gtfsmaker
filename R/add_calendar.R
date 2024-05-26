#' @title Add a calendar to the GTFS
#' @name add_calendar
#'
#' @description Add calendar information (number of the service concerned, every day of the week, service start and end dates).
#'
#' @param service_id Identification number of the service concerned
#' @param monday Indicates whether the service operates every Monday (0 if unavailable, 1 if available)
#' @param tuesday Indicates whether the service operates every Tuesday (0 if unavailable, 1 if available)
#' @param wednesday Indicates whether the service operates every Wednesday (0 if unavailable, 1 if available)
#' @param thursday Indicates whether the service operates every Thursday (0 if unavailable, 1 if available)
#' @param friday Indicates whether the service operates every Friday (0 if unavailable, 1 if available)
#' @param saturday Indicates whether the service operates every Saturday (0 if unavailable, 1 if available)
#' @param sunday Indicates whether the service operates every Sunday (0 if unavailable, 1 if available)
#' @param start_date Start service day for the service interval
#' @param end_date End service day for the service interval (this service day is included in the interval)
#'
#' @return Add a new row to the \code{Calendar} object corresponding to the new calendar's information.
#' @export
#'
#' @examples
#' add_calendar(1, 1, 1, 1, 1, 1, 1, 1, 20240511, 20241231)
add_calendar <- function(service_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday, start_date, end_date) {

  trips <- globalenv()$trips

  if (!(service_id %in% trips$service_id)) {
    message("Erreur: service_id '", service_id, "' n'existe pas dans trips$service_id")
    return(invisible())
  }

  if (any(!c(monday, tuesday, wednesday, thursday, friday, saturday, sunday) %in% c(0, 1))) {
    stop("Erreur: Les valeurs des jours doivent être 0 ou 1.")
  }

  new_row <- data.frame(service_id = service_id,
                        monday = monday,
                        tuesday = tuesday,
                        wednesday = wednesday,
                        thursday = thursday,
                        friday = friday,
                        saturday = saturday,
                        sunday = sunday,
                        start_date = start_date,
                        end_date = end_date
                        )

  calendar <<- rbind(calendar, new_row)
}
