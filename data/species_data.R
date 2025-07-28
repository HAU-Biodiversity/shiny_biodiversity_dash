# Load libraries
library(readxl)
library(tidyverse)

## Read in data ----
master_species_data <- read_excel("data/Master_species_observation_list.xlsx",
    sheet = "species_observations",
    col_types = c(
        "numeric", "text", "text", "text", "numeric", "numeric", "text", "text", "text", "text", "text", "text", "text", "text",
        "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text",
        "text", "text", "text", "text", "text", "logical", "numeric", "text", "text", "text", "text"
    )
) %>%
    mutate(
        date_num = suppressWarnings(as.Date(as.numeric(date), origin = "1899-12-30")),
        date_text = suppressWarnings(dmy(date)),
        date_final = coalesce(date_text, date_num)
    )

ms_data <- master_species_data %>%
    mutate(year_final = coalesce(
        year, # use this if it's not NA
        year(ymd(date_final))
    ))

# glimpse(ms_data)

## Read in taxon group list
taxonList <- read_excel("data/Master_species_observation_list.xlsx", sheet = "Taxon_groups")

## Create required variables ----

# get latest & previous year
sp_current_YTD <- get_latest_year(ms_data, year_var = year_final)
sp_currentFullYear <- sp_latestYear - 1
sp_prev_FullYear <- sp_currentFullYear - 1

## Species count YTD
byYeartaxon_uniqueSpecies_count <- ms_data %>%
    group_by(year_final, taxon_group) %>%
    summarise(n_species = n_distinct(sci_name)) %>%
    arrange(desc(n_species))

byYear_uniqueSpecies_count <- ms_data %>%
    group_by(year_final) %>%
    summarise(n_species = n_distinct(sci_name)) %>%
    arrange(desc(n_species))

# species count for year to date
current_YTD_sp_count <- byYear_uniqueSpecies_count %>%
    filter(year_final == sp_current_YTD)

# species count last year
current_FullYear_sp_count <- byYear_uniqueSpecies_count %>%
    filter(year_final == sp_currentFullYear)

prev_FullYear_sp_count <- byYear_uniqueSpecies_count %>%
    filter(year_final == sp_prev_FullYear)

## Total taxon groups
totalTaxonGroups <- taxonList %>%
    summarise(n_taxon = n_distinct(taxonGroup))

## Taxon groups surveyed
current_YTD_surveyedTaxon <- byYeartaxon_uniqueSpecies_count %>%
    filter(year_final == sp_current_YTD) %>%
    group_by(year_final) %>%
    summarise(n_taxon = n_distinct(taxon_group))

current_FullYear_surveyedTaxon <- byYeartaxon_uniqueSpecies_count %>%
    filter(year_final == sp_currentFullYear) %>%
    group_by(year_final) %>%
    summarise(n_taxon = n_distinct(taxon_group))

prev_FullYear_surveyedTaxon <- byYeartaxon_uniqueSpecies_count %>%
    filter(year_final == sp_prev_FullYear) %>%
    group_by(year_final) %>%
    summarise(n_taxon = n_distinct(taxon_group))

sp_YTD_FullYear_message <- change_message(current_YTD_sp_count$n_species, current_FullYear_sp_count$n_species)
taxon_YTD_FullYear_message <- change_message(current_YTD_surveyedTaxon$n_taxon, current_FullYear_surveyedTaxon$n_taxon)

sp_FullPrev_message <- change_message(current_FullYear_sp_count$n_species, prev_FullYear_sp_count$n_species)
taxon_FullPrev_message <- change_message(current_FullYear_surveyedTaxon$n_taxon, prev_FullYear_surveyedTaxon$n_taxon)

## Taxon Group Trends

# Create number of species per taxon group per year
sp_per_taxon <- ms_data %>%
    group_by(year_final, taxon_group) %>%
    summarise(n_species = n_distinct(sci_name)) %>%
    arrange(desc(year_final))

# GRaph
# Create unique species lists
allTime_uniqueSpecies <- master_species_data %>%
    distinct(sci_name)

allTime_uniqueSpecies_count <- master_species_data %>%
    summarise(n_species = n_distinct(sci_name))

byYear_uniqueSpecies <- ms_data %>%
    group_by(year_final) %>%
    distinct(sci_name)
