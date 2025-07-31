source("data/habitat_data.R")
source("data/shp_files/RPA/prep.R")

habitats_ui <- function(id) {
    ns <- NS(id)

    tagList(
        h2("Habitats"),
        layout_column_wrap(
            width = 1 / 3,
            value_box(
                title = "Area of semi-natural habitat",
                value = semiNatCover,
                tags$p("ha"),
                showcase = icon("tree"),
                showcase_layout = "top right",
                theme_color = "primary"
            ),
            value_box(
                title = "Biodiveristy Index",
                value = "0.47",
                showcase = icon("feather-pointed"),
                showcase_layout = "top right",
                theme_color = "secondary"
            ),
            value_box(
                title = "Habitat Connectivity",
                value = "0.1",
                showcase = icon("circle-nodes"),
                showcase_layout = "top right",
                theme_color = "secondary"
            )
        ),
        layout_columns(
            col_widths = c(4, 8),
            div(
                h5("Habitat distinctiveness"),
                layout_column_wrap(
                    width = 1 / 2,
                    value_box(
                        title = "High",
                        value = "2.5%",
                        theme_color = "success"
                    ),
                    value_box(
                        title = "Medium",
                        value = "4.6%",
                        theme_color = "info"
                    ),
                    value_box(
                        title = "Low",
                        value = "91.0%",
                        theme_color = "warning"
                    ),
                    value_box(
                        title = "Very Low",
                        value = "1.9%",
                        theme_color = "danger"
                    ),
                )
            ),
            leafletOutput(ns("habMap"))
        )
    )
}


habitats_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        # Add plots when ready
        shapesrds <- readRDS("data/shp_files/RPA/landPaecels.rds")
        output$habMap <- renderLeaflet({
            leaflet() %>%
                addTiles() %>%
                setView(lng = -2.4271792, lat = 52.779411, zoom = 13) %>%
                addMarkers(lng = -2.4271792, lat = 52.779411, popup = "Harper Adams University") %>%
                addPolygons(
                    data = shapesrds,
                    color = "grey",
                    weight = 2,
                    opacity = 0.8,
                    fillOpacity = 0.4,
                    popup = ~ paste(
                        "Parcel ID: ", PARCEL_ID, "<br>"
                    )
                )
        })
    })
}
