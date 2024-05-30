#' @title Repeat a trip sequence for other timetables
#'
#' @description Repeat a sequence of journeys for other times according to a specific frequency
#'
#' @param trip_id identification number of the trip concerned
#' @param max_time The maximum time that must not be exceeded
#' @param breaks The number of minutes between two trips until the maximum time is reached
#'
#' @return Add new rows to the `stop_times` object.
#' @export
#'
#' @examples
#' repeat_stop_times(1, "23:00:00", 7)
repeat_stop_times <- function(trip_id, max_time, breaks) {

  stop_times <- as.data.frame(globalenv()$stop_times)
  trips <- as.data.frame(globalenv()$trips)

  trip_number <- trip_id

  if(nrow(stop_times) == 0) {
    message("Error")
    return(invisible())
  }

  nouveau_df <- stop_times %>%
    filter(trip_id == trip_number & stop_sequence == 1)

  horaire <- as.POSIXct(max_time, format = "%H:%M:%S")

  if(horaire < (nouveau_df$arrival_time + (breaks*60))) {
    message("Horaire maximal inferieur ou egal a l'horaire de reference")
    return(invisible())
  }

  horaires <- seq(from = nouveau_df$arrival_time,
                  to = horaire,
                  by = paste(breaks, "min"))

  horaires <- tail(horaires, -1)

  stop_times2 <- stop_times %>%
    filter(trip_id == trip_number)

  stop_times2$diff_minutes <- c(0, diff(stop_times2$arrival_time, units = "mins"))
  stop_times2$cumulative_sum <- cumsum(stop_times2$diff_minutes)*60

  liste_df_modifies <- list()

  liste_df_trips <- list()

  for (i in 1:length(horaires)) {

        df_modifie <- stop_times %>%
          filter(trip_id == trip_number)

    trips2 <- trips %>%
      filter(trip_id == trip_number)

    df_modifie$arrival_time <- horaires[i] + stop_times2$cumulative_sum
    df_modifie$departure_time <- horaires[i] + stop_times2$cumulative_sum

    df_modifie$trip_id <- max(stop_times$trip_id) + (i)

    trips2$trip_id <- max(trips$trip_id) + (i)

    liste_df_modifies[[i]] <- df_modifie

    liste_df_trips[[i]] <- trips2

  }

  test <- do.call(rbind, liste_df_modifies)

  test_trips <- do.call(rbind, liste_df_trips)

  stop_times <<- rbind(stop_times, test)

  trips <<- rbind(trips, test_trips)
}
