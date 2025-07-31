library(readxl)
library(tidyverse)

bioIndex <- read_excel("data/habitat_data.xlsx", sheet = "Sheet1")
# glimpse(bioIndex)

distinctiveness <- read_excel("data/habitat_data.xlsx", sheet = "distinctiveness")
# glimpse(distinctiveness)

habCover <- read_excel("data/habitat_data.xlsx", sheet = "habitat_cover")
# glimpse(habCover)

connectivity <- read_excel("data/habitat_data.xlsx", sheet = "Connectivity")
# glimpse(connectivity)

waterHedges <- read_excel("data/habitat_data.xlsx", sheet = "Sheet5")
# glimpse(waterHedges)


currentYear <- get_latest_year(bioIndex, Year)

semiNatCover <- habCover %>%
    filter(source == "LandApp") %>%
    filter(semi_natural == "yes") %>%
    summarise(semiNatHabTot = sum(cover_ha))

totCover <- habCover %>%
    filter(source == "Landapp") %>%
    select(cover_ha)

woodland <- habCover %>%
    filter(source == "LandApp") %>%
    filter(Habitat_type == "Woodland/forest") %>%
    select(cover_ha)

hedgeLength <- waterHedges %>%
    filter(year == currentYear) %>%
    filter(category == "Hedgerow(km)") %>%
    select(quantity)

aquatic <- habCover %>%
    filter(source == "LandApp") %>%
    filter(Habitat_type == "Rivers/lakes") %>%
    select(cover_ha)
