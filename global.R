get_latest_year <- function(data, year_var = year) {
    year_var <- rlang::enquo(year_var)
    data %>%
        dplyr::filter(!is.na(!!year_var)) |>
        dplyr::summarise(latest_year = max(!!year_var, na.rm = TRUE)) |>
        dplyr::pull(latest_year)
}

change_message <- function(current, previous) {
    change <- current - previous

    if (is.na(previous)) {
        return("No previous data to compare")
    }

    if (change > 0) {
        paste0("⬆ Increased by ", change, " since last year")
    } else if (change < 0) {
        paste0("⬇ Decreased by ", abs(change), " since last year")
    } else {
        "No change since last year"
    }
}


apply_custom_plotly_style <- function(data_plot) {
    data_plot %>% layout(
        font = list(size = 14, family = "Arial", color = "black")
    )
}
