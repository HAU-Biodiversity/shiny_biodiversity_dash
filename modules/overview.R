overview_ui <- function(id) {
    ns <- NS(id)

    tagList(
        h2("Overview", class = "mb-4"),

        # Summary cards
        layout_column_wrap(
            width = 1 / 4,
            value_box(
                title = "Land area",
                value = "x",
                tags$p("ha"),
                showcase = icon("map"),
                showcase_layout = "top right",
                theme_color = "primary"
            ),
            value_box(
                title = "Area of semi-natural habitat",
                value = semiNatCover,
                tags$p("ha"),
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "primary"
            ),
            value_box(
                title = "Unique species",
                value = "x",
                showcase = icon("fingerprint"),
                showcase_layout = "top right",
                theme_color = "primary"
            ),
            value_box(
                title = "Carbon emissions",
                value = "x",
                showcase = icon("wind"),
                showcase_layout = "top right",
                theme_color = "primary"
            )
        ),
        br(),
        h4("Biodiversity"),
        div(
            h5("Species Trends"),
            layout_columns(
                col_widths = c(9, 3),
                plotlyOutput(ns("speciesPlot1")),
                p("Plot side bar here")
            )
        ),
        br(),
        layout_columns(
            col_widths = c(6, 6),

            # Left: Habitat plot + info
            div(
                h4("Habitats"),
                layout_columns(
                    col_widths = c(8, 4),
                    plotlyOutput(ns("habitatPlot")),
                    value_box(
                        title = "Agri-env schemes",
                        value = "x",
                        showcase = icon("feather"),
                        showcase_layout = "top right",
                        theme_color = "primary"
                    )
                )
            ),

            # Right: Carbon plot + info
            div(
                h4("Carbon"),
                layout_columns(
                    col_widths = c(8, 4),
                    plotlyOutput(ns("carbonPlot")),
                    layout_column_wrap(
                        width = 1,
                        value_box(
                            title = "Largest Sector",
                            value = "x",
                            showcase = icon("suitcase"),
                            showcase_layout = "top right",
                            theme_color = "primary"
                        ),
                        value_box(
                            title = "Biggest Source Type",
                            value = "x",
                            showcase = icon("arrows-to-dot"),
                            showcase_layout = "top right",
                            theme_color = "primary"
                        )
                    )
                )
            )
        )
    )
}


overview_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        # Add plots when ready
        output$speciesPlot1 <- renderPlotly({
            plot_ly() %>%
                layout(
                    xaxis = list(visible = FALSE),
                    yaxis = list(visible = FALSE),
                    plot_bgcolor = "#f0f0f0", # grey plot area
                    paper_bgcolor = "#f0f0f0", # grey outer area
                    annotations = list(
                        text = "Coming soon",
                        x = 0.5,
                        y = 0.5,
                        showarrow = FALSE,
                        font = list(size = 18)
                    )
                )
        })

        output$speciesPlot2 <- renderPlotly({
            plot_ly() %>%
                layout(
                    xaxis = list(visible = FALSE),
                    yaxis = list(visible = FALSE),
                    plot_bgcolor = "#f0f0f0", # grey plot area
                    paper_bgcolor = "#f0f0f0", # grey outer area
                    annotations = list(
                        text = "Coming soon",
                        x = 0.5,
                        y = 0.5,
                        showarrow = FALSE,
                        font = list(size = 18)
                    )
                )
        })

        output$speciesPlot3 <- renderPlotly({
            plot_ly() %>%
                layout(
                    xaxis = list(visible = FALSE),
                    yaxis = list(visible = FALSE),
                    plot_bgcolor = "#f0f0f0", # grey plot area
                    paper_bgcolor = "#f0f0f0", # grey outer area
                    annotations = list(
                        text = "Coming soon",
                        x = 0.5,
                        y = 0.5,
                        showarrow = FALSE,
                        font = list(size = 18)
                    )
                )
        })

        output$habitatPlot <- renderPlotly({
            plot_ly() %>%
                layout(
                    xaxis = list(visible = FALSE),
                    yaxis = list(visible = FALSE),
                    plot_bgcolor = "#f0f0f0", # grey plot area
                    paper_bgcolor = "#f0f0f0", # grey outer area
                    annotations = list(
                        text = "Coming soon",
                        x = 0.5,
                        y = 0.5,
                        showarrow = FALSE,
                        font = list(size = 18)
                    )
                )
        })

        output$carbonPlot <- renderPlotly({
            plot_ly() %>%
                layout(
                    xaxis = list(visible = FALSE),
                    yaxis = list(visible = FALSE),
                    plot_bgcolor = "#f0f0f0", # grey plot area
                    paper_bgcolor = "#f0f0f0", # grey outer area
                    annotations = list(
                        text = "Coming soon",
                        x = 0.5,
                        y = 0.5,
                        showarrow = FALSE,
                        font = list(size = 18)
                    )
                )
        })
    })
}
