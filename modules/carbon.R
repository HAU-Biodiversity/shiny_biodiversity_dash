carbon_ui <- function(id) {
    ns <- NS(id)


    tagList(
        h2("Carbon Emissions"),
        layout_column_wrap(
            width = 1 / 6,
            value_box(
                title = "Total Carbon Equivalent",
                value = "x",
                showcase = icon("wind"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Est. Carbon sequestration",
                value = "x",
                showcase = icon("seedling"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Est. net carbon",
                value = "x",
                showcase = icon("equals"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Highest enterprise",
                value = "x",
                showcase = icon("suitcase"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Largest Source",
                value = "x",
                showcase = icon("arrows-to-dot"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Highest gas emission",
                value = "x",
                showcase = icon("turn-up"),
                showcase_layout = "top right",
                theme_color = "success"
            )
        ),
        br(),
        h4("Whole Farm Emissions"),
        br(),
        layout_column_wrap(
            width = 1 / 3,
            div(
                h5("Emissions by Enterprise"),
                plotlyOutput(ns("carbonPlot1")),
            ),
            div(
                h5("Emissions by Source"),
                plotlyOutput(ns("carbonPlot2")),
            ),
            div(
                h5("Emissions by Gas"),
                plotlyOutput(ns("carbonPlot3"))
            )
        ),
        br(),
        h4("Enterprise Emissions"),
        br(),
        layout_columns(
            col_widths = c(4, 8),
            div(
                layout_column_wrap(
                    width = 1 / 2,
                    value_box(
                        title = "Total carbon equiv.",
                        value = "x",
                        showcase = icon("wind"),
                        showcase_layout = "top right",
                        theme_color = "success"
                    ),
                    value_box(
                        title = "Largest Source",
                        value = "x",
                        showcase = icon("arrows-to-dot"),
                        showcase_layout = "top right",
                        theme_color = "success"
                    ),
                    value_box(
                        title = "Product emissions",
                        value = "x",
                        showcase = icon("suitcase"),
                        showcase_layout = "top right",
                        theme_color = "success"
                    ),
                    value_box(
                        title = "Highest gas emission",
                        value = "x",
                        showcase = icon("turn-up"),
                        showcase_layout = "top right",
                        theme_color = "success"
                    )
                )
            ),
            div(
                layout_column_wrap(
                    width = 1 / 2,
                    div(
                        h5("Emissions by Source"),
                        plotlyOutput(ns("carbonPlot4")),
                    ),
                    div(
                        h5("Emissions by Gas"),
                        plotlyOutput(ns("carbonPlot5"))
                    )
                )
            )
        )
    )
}


carbon_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        # Add plots when ready
        output$carbonPlot1 <- renderPlotly({
            plot_ly() %>%
                layout(
                    title = "",
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

        output$carbonPlot2 <- renderPlotly({
            plot_ly() %>%
                layout(
                    title = "",
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

        output$carbonPlot3 <- renderPlotly({
            plot_ly() %>%
                layout(
                    title = "",
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

        output$carbonPlot4 <- renderPlotly({
            plot_ly() %>%
                layout(
                    title = "",
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

        output$carbonPlot5 <- renderPlotly({
            plot_ly() %>%
                layout(
                    title = "",
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
