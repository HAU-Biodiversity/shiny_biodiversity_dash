## Load libraries
library(readxl)
library(tidyverse)

# Read in data ----
# Read in generic scores data
ctf_gen_scores <- read_excel("data/CFT_summary_score_data.xlsx", sheet = "generalScores") |>
    mutate(across(c("category"), ~ as.factor(.x)))
# glimpse(ctf_gen_scores)

# Read in species scores data
ctf_sp_scores <- read_excel("data/CFT_summary_score_data.xlsx", sheet = "speciesScores") |>
    mutate(across(c("category"), ~ as.factor(.x)))
# glimpse(ctf_sp_scores)

# Read in land cover data
ctf_landcover <- read_excel("data/CFT_summary_score_data.xlsx", sheet = "landCover") |>
    mutate(across(c("landCoverType"), ~ as.factor(.x)))
# glimpse(ctf_landcover)

# Get latest years ----
latestYear_genScores <- get_latest_year(ctf_gen_scores)
latestYear_spScores <- get_latest_year(ctf_sp_scores)
latestYear_landCover <- get_latest_year(ctf_landcover)

# Create summary values ----
# General Scores summaries
farmProdScore <-
    ctf_gen_scores |>
    filter(year == latestYear_genScores & category == "Farmed Products") |>
    select(percentScore)

farmPracScore <-
    ctf_gen_scores |>
    filter(year == latestYear_genScores & category == "Farming Practices") |>
    select(percentScore)

largeHabScore <-
    ctf_gen_scores |>
    filter(year == latestYear_genScores & category == "Large Habitats") |>
    select(percentScore)

smallHabScore <-
    ctf_gen_scores |>
    filter(year == latestYear_genScores & category == "Small Habitats") |>
    select(percentScore)

# Species scores summaries
lowestSpScore <- ctf_sp_scores |>
    filter(year == latestYear_spScores) |>
    arrange(percentScore) |>
    slice(1)

highestSpScore <- ctf_sp_scores |>
    filter(year == latestYear_spScores) |>
    arrange(desc(percentScore)) |>
    slice(1)

## Create plots ----
# General Scores plot
ctf_gen_scores_plot <-
    plot_ly(
        data = ctf_gen_scores,
        x = ~year,
        y = ~percentScore,
        name = ~category,
        type = "bar",
        text = ~category,
        textposition = "none",
        hovertemplate = paste(
            "<b>Score:</b> %{y:.1f}%<br>"
        )
    ) %>%
    layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Score (%)"),
        barmode = "group" # ,
        # showlegend = FALSE
    ) %>%
    config(
        displayModeBar = FALSE
    )

# Species Scores plot
ctf_sp_scores_plot <-
    plot_ly(
        data = ctf_sp_scores,
        x = ~year,
        y = ~percentScore,
        name = ~category,
        type = "bar",
        text = ~category,
        textposition = "none",
        hovertemplate = paste(
            "<b>Score:</b> %{y:.1f}%<br>"
        )
    ) %>%
    layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Score (%)"),
        barmode = "group" # ,
        # showlegend = FALSE
    ) %>%
    config(
        displayModeBar = FALSE
    )

# Land cover plot
ctf_landcover_plot <-
    plot_ly(
        data = ctf_landcover,
        x = ~year,
        y = ~percentCover,
        name = ~landCoverType,
        type = "bar",
        text = ~landCoverType,
        textposition = "none",
        customdata = ~landArea,
        hovertemplate = paste(
            "<b>Score:</b> %{y:.1f}%<br>",
            "<b>Total land area:</b> %{customdata}<br>"
        )
    ) %>%
    layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Score (%)"),
        barmode = "group" # ,
        # showlegend = FALSE
    ) %>%
    config(
        displayModeBar = FALSE
    )

# Land area plot
ctf_landcover_summary <- ctf_landcover |>
    mutate(across(c(year), ~ as.factor(.x))) |>
    group_by(year) |>
    summarise(landArea = landArea[1])


ctf_landarea_plot <-
    plot_ly(
        data = ctf_landcover_summary,
        x = ~year,
        y = ~landArea,
        type = "bar",
        textposition = "none",
        hovertemplate = paste(
            "<b>Land Area:</b> %{y:.1f} ha<extra></extra><br>"
        )
    ) %>%
    layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = "Area (ha)") # ,
        # showlegend = FALSE
    ) %>%
    config(
        displayModeBar = FALSE
    )
