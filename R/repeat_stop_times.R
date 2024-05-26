#' @title Repeat a trip sequence for other timetables
#'
#' @description Repeat a sequence of journeys for other times according to a specific frequency
#'
#' @param trip_id_n identification number of the trip concerned
#' @param horaire The maximum time that must not be exceeded
#' @param temps The number of minutes between two trips until the maximum time is reached
#'
#' @return Add new rows to the `stop_times` object.
#' @export
#'
#' @examples
#' repeat_stop_times(1, "23:00:00", 7)
repeat_stop_times <- function(trip_id_n, horaire, temps) {

  stop_times <- as.data.frame(globalenv()$stop_times)
  trips <- as.data.frame(globalenv()$trips)

  if(nrow(stop_times) == 0) {
    return("Error")
  }

  nouveau_df <- subset(stop_times,
                       stop_times$trip_id == trip_id_n & stop_times$stop_sequence == 1)

  horaire <- as.POSIXct(horaire, format = "%H:%M:%S")

  if(horaire < (nouveau_df$arrival_time + (temps*60))) {
    return("Horaire maximal inférieur ou égal à l'horaire de référence")
  }

  horaires <- seq(from = nouveau_df$arrival_time,
                  to = horaire,
                  by = paste(temps, "min"))

  horaires <- tail(horaires, -1)

  stop_times2 <- subset(stop_times, stop_times$trip_id == trip_id_n)
  stop_times2$diff_minutes <- c(0, diff(stop_times2$arrival_time, units = "mins"))
  stop_times2$cumulative_sum <- cumsum(stop_times2$diff_minutes)*60

  liste_df_modifies <- list()

  liste_df_trips <- list()

  for (i in 1:length(horaires)) {

        df_modifie <- subset(stop_times, stop_times$trip_id == trip_id_n)

    trips2 <- subset(trips, trip_id == trip_id_n)

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
