source("data/species_data.R")

species_ui <- function(id) {
    ns <- NS(id)

    tagList(
        h2("Species information"),
        div(
            layout_column_wrap(
                width = 1 / 4,
                value_box(
                    title = paste0("Total species YTD ", sp_current_YTD),
                    value = current_YTD_sp_count$n_species,
                    tags$p(sp_YTD_FullYear_message),
                    showcase = icon("leaf"),
                    showcase_layout = "top right",
                    theme_color = "primary"
                ),
                value_box(
                    title = paste0("Total species last year ", sp_currentFullYear),
                    value = current_FullYear_sp_count$n_species,
                    tags$p(sp_FullPrev_message),
                    showcase = icon("leaf"),
                    showcase_layout = "top right",
                    theme_color = "secondary"
                ),
                value_box(
                    title = paste0("Taxon groups surveyed YTD ", sp_current_YTD),
                    value = current_YTD_surveyedTaxon$n_taxon,
                    tags$p(taxon_YTD_FullYear_message),
                    showcase = icon("leaf"),
                    showcase_layout = "top right",
                    theme_color = "primary"
                ),
                value_box(
                    title = paste0("Taxon groups surveyed last year ", sp_currentFullYear),
                    value = current_FullYear_surveyedTaxon$n_taxon,
                    tags$p(taxon_FullPrev_message),
                    showcase = icon("leaf"),
                    showcase_layout = "top right",
                    theme_color = "secondary"
                ),
            )
        ),
        br(),
        div(
            h5("Taxon Group Trends"),
            tabsetPanel(
                tabPanel(
                    title = "Plot",
                    layout_columns(
                        col_widths = c(9, 3),
                        plotlyOutput(ns("taxonPlot")),
                        # Filters
                        div(
                            actionButton(ns("toggle_taxa"), "Deselect All Taxa"),
                            checkboxGroupInput(
                                inputId = ns("taxon_choice"),
                                "Choose taxon group(s):",
                                choices = NULL,
                                # selected = NULL
                            )
                        )
                    ),
                    br(),
                ),
                tabPanel(
                    title = "Data",
                    DTOutput(ns("taxonTable"))
                )
            )
        ),
        br(),
        div(
            h5("Species Trends"),
            layout_columns(
                col_widths = c(9, 3),
                plotlyOutput(ns("speciesPlot")),
                p("Plot side bar here")
            )
        )
    )
}


species_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        # populate choices dynamically
        taxon_choices <- unique(sp_per_taxon$taxon_group)
        observe({
            updateCheckboxGroupInput(
                session,
                inputId = "taxon_choice",
                choices = taxon_choices,
                selected = taxon_choices
            )
        })

        # Select/clear all taxa
        # Reactive state to track toggle status
        taxa_all_selected <- reactiveVal(TRUE)

        observeEvent(input$toggle_taxa, {
            if (taxa_all_selected()) {
                updateCheckboxGroupInput(session, "taxon_choice", selected = character(0))
                taxa_all_selected(FALSE)
                updateActionButton(session, "toggle_taxa", label = "Select All Taxa")
            } else {
                updateCheckboxGroupInput(session, "taxon_choice", selected = taxon_choices)
                taxa_all_selected(TRUE)
                updateActionButton(session, "toggle_taxa", label = "Deselect All Taxa")
            }
        })

        observeEvent(input$taxon_choice, {
            all_selected <- setequal(input$taxon_choice, taxon_choices)
            taxa_all_selected(all_selected)

            updateActionButton(
                session,
                "toggle_taxa",
                label = if (all_selected) "Deselect All Taxa" else "Select All Taxa"
            )
        })



        # Add plots when ready

        taxon_colors <- RColorBrewer::brewer.pal(n = length(taxon_choices), name = "Set2")
        taxon_color_map <- setNames(taxon_colors, taxon_choices)


        output$taxonPlot <- renderPlotly({
            req(input$taxon_choice)

            filtered <- sp_per_taxon %>%
                filter(taxon_group %in% input$taxon_choice) %>%
                arrange(year_final)

            plot_ly(
                data = filtered,
                x = ~year_final,
                y = ~n_species,
                color = ~taxon_group,
                colors = taxon_color_map,
                type = "bar",
                text = ~taxon_group,
                textposition = "none",
                hovertemplate = paste(
                    "<b>Number of Species:</b> %{y:.0f}<br>",
                    "<b>Year:</b> %{x:.0f}<br>"
                )
            ) %>%
                layout(
                    barmode = "stack", # <--- stacked bar mode
                    xaxis = list(
                        title = "Year",
                        tickformat = ".0f",
                        dtick = 1
                    ),
                    yaxis = list(title = "Number of species recorded"),
                    legend = list(
                        orientation = "h",
                        x = 0,
                        y = -0.2,
                        xanchor = "left",
                        yanchor = "top"
                    ),
                    margin = list(b = 100)
                ) %>%
                config(
                    displayModeBar = FALSE
                )
        })

        output$taxonTable <- renderDT({
            datatable(sp_per_taxon,
                rownames = FALSE,
                colnames = c(
                    "Year" = "year_final",
                    "Taxon Group" = "taxon_group",
                    "Number of Species" = "n_species"
                )
            )
        })

        output$speciesPlot <- renderPlotly({
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
