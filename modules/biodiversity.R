source("data/cft_data.R")


biodiversity_ui <- function(id) {
    ns <- NS(id)

    tagList(
        h3("Cool Farm Toolkit Biodiversity Assessment"),
        br(),
        layout_column_wrap(
            width = 1 / 4,
            value_box(
                title = "Farming product score",
                value = paste0(farmProdScore$percentScore, "%"),
                tags$p("Year: ", latestYear_genScores),
                showcase = icon("wheat-awn"),
                showcase_layout = "top right",
                theme_color = "primary"
            ),
            value_box(
                title = "Farming practices score",
                value = paste0(farmPracScore$percentScore, "%"),
                tags$p("Year: ", latestYear_genScores),
                showcase = icon("tractor"),
                showcase_layout = "top right",
                theme_color = "primary"
            ),
            value_box(
                title = paste0("Large Habitat Score"),
                value = paste0(largeHabScore$percentScore, "%"),
                tags$p("Year: ", latestYear_genScores),
                showcase = icon("tree"),
                showcase_layout = "top right",
                theme_color = "secondary"
            ),
            value_box(
                title = "Small Habitat Score",
                value = paste0(smallHabScore$percentScore, "%"),
                tags$p("Year: ", latestYear_genScores),
                showcase = icon("seedling"),
                showcase_layout = "top right",
                theme_color = "secondary"
            ),
        ),
        layout_column_wrap(
            width = 1 / 2,
            value_box(
                title = "Species group with highest score",
                value = highestSpScore$category,
                tags$p("Year: ", latestYear_spScores),
                showcase = icon("gauge-simple-high"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Species group with lowest score",
                value = lowestSpScore$category,
                tags$p("Year: ", latestYear_spScores),
                showcase = icon("gauge-simple-high", class = "fa-flip-horizontal"),
                showcase_layout = "top right",
                theme_color = "warning"
            ),
        ),
        br(),
        tabsetPanel(
            tabPanel(
                title = "General Scores",
                plotlyOutput(ns("cftPlot1"))
            ),
            tabPanel(
                title = "Species Group Scores",
                plotlyOutput(ns("cftPlot2"))
            ),
            tabPanel(
                title = "Land Cover",
                plotlyOutput(ns("cftPlot3")),
                tags$p("Note: Total land area changes across years. Hover over bar to see relevant total land area for the year.")
            ),
            tabPanel(
                title = "Land Area",
                plotlyOutput(ns("cftPlot4"))
            )
        ),
        br(),
        fluidRow(
            column(8, h5("Data Tables")),
            column(4, align = "right", actionLink(ns("toggle_cft_datatable"), em("(Show)")))
        ),
        div(
            id = ns("cft_datatabs"),
            style = "display: none",
            tabsetPanel(
                tabPanel(
                    title = "General Scores",
                    DTOutput(ns("genScore_table"))
                ),
                tabPanel(
                    title = "Species Group Scores",
                    DTOutput(ns("spScore_table"))
                ),
                tabPanel(
                    title = "Land Cover",
                    DTOutput(ns("landCover_table"))
                ),
                tabPanel(
                    title = "Land Area",
                    DTOutput(ns("landArea_table"))
                )
            )
        )
    )
}


biodiversity_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        # Add plots when ready
        output$cftPlot1 <- renderPlotly({
            ctf_gen_scores_plot
        })

        output$cftPlot2 <- renderPlotly({
            ctf_sp_scores_plot
        })

        output$cftPlot3 <- renderPlotly({
            ctf_landcover_plot
        })

        output$cftPlot4 <- renderPlotly({
            ctf_landarea_plot
        })
        # table js toggle
        # Track toggle state
        is_hidden <- reactiveVal(TRUE)

        observeEvent(input$toggle_cft_datatable, {
            toggle("cft_datatabs")
            # Flip state
            is_hidden(!is_hidden())
            # Update label
            new_label <- if (is_hidden()) "<em>(Show)</em>" else "<em>(Hide)</em>"
            updateActionLink(session, "toggle_cft_datatable", label = new_label)
        })
        # Tables

        output$genScore_table <- renderDT({
            datatable(ctf_gen_scores,
                rownames = FALSE,
                colnames = c(
                    "Year" = "year",
                    "Land Area (ha)" = "landArea",
                    "Category" = "category",
                    "Score (%)" = "percentScore"
                )
            )
        })

        output$spScore_table <- renderDT({
            datatable(ctf_sp_scores |> select(-c(numScore, totPossScore)),
                rownames = FALSE,
                colnames = c(
                    "Year" = "year",
                    "Land Area (ha)" = "landArea",
                    "Category" = "category",
                    "Score (%)" = "percentScore"
                )
            )
        })

        output$landCover_table <- renderDT({
            datatable(ctf_landcover,
                rownames = FALSE,
                colnames = c(
                    "Year" = "year",
                    "Land Area (ha)" = "landArea",
                    "Land Cover Type" = "landCoverType",
                    "Land Cover (%)" = "percentCover"
                )
            )
        })

        output$landArea_table <- renderDT({
            datatable(ctf_landcover_summary,
                rownames = FALSE,
                colnames = c(
                    "Year" = "year",
                    "Land Area (ha)" = "landArea"
                )
            )
        })
    })
}
