agEnv_ui <- function(id) {
    ns <- NS(id)

    tagList(
        h2("Agri-Environment Schemes"),
        layout_column_wrap(
            width = 1 / 6,
            value_box(
                title = "Total area in ag env schemes",
                value = "x",
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Total hedgerow in schemes",
                value = "x",
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Pollinator mix area",
                value = "x",
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Wild bird seed mix area",
                value = "x",
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Ground nesting bird plot area",
                value = "x",
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Grassy margins area",
                value = "x",
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
        ),
        layout_columns(
            col_widths = c(4, 8),
            card(p("Habitat quality things here")),
            card(p("Map will go here"))
        )
    )
}


agEnv_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        # Add plots when ready
    })
}
