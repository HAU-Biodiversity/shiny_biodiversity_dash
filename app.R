library(shiny)
library(shinydashboard)
library(bslib)
library(bsicons)
library(plotly)
library(htmltools)
library(leaflet)
library(sf)
library(DT)
library(shinyjs)
# library(sf)

# Source module files
source("modules/overview.R")
source("global.R")
source("modules/species.R")
source("modules/habitats.R")
source("modules/carbon.R")
source("modules/biodiversity.R")
# source("modules/agEnvSchemes.R")


ui <- navbarPage(
    title = "HAU Biodiversity Dashboard",
    useShinyjs(),
    theme = bs_theme(bootswatch = "flatly", base_font = font_google("Open Sans")),
    tabPanel("Overview", overview_ui("overview")),
    tabPanel("Species", species_ui("species")),
    tabPanel("Habitats", habitats_ui("habitats")),
    tabPanel("Carbon", carbon_ui("carbon")),
    tabPanel("Biodiversity Assessments", biodiversity_ui("biodiversity")),
    # tabPanel("Agri-Env. Schemes", agEnv_ui("agEnv")),
    tabPanel("More info", "Coming soon"),
    tags$footer(
        class = "text-center",
        style = "padding: 10px; margin: 0px; background-color: #f9f9f9; font-size: 0.9em; color: #666;",
        HTML("&copy; 2025 Harper Adams University - AgriDat")
    )
)

server <- function(input, output, session) {
    overview_server("overview")
    species_server("species")
    habitats_server("habitats")
    biodiversity_server("biodiversity")
    carbon_server("carbon")
    # agEnv_server("agEnv")
}

shinyApp(ui, server)
