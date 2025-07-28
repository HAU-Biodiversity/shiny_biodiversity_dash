habitats_ui <- function(id) {
    ns <- NS(id)

    tagList(
        h2("Habitats"),
        layout_column_wrap(
            width = 1 / 6,
            value_box(
                title = "Total area",
                value = "x",
                showcase = icon("map"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Total area of semi-natural habitat",
                value = "x",
                showcase = icon("leaf"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Total area in ag env schemes",
                value = "x",
                showcase = icon("feather"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Total hedgerow length",
                value = "x",
                showcase = icon("ruler"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Total woodland area",
                value = "x",
                showcase = icon("tree"),
                showcase_layout = "top right",
                theme_color = "success"
            ),
            value_box(
                title = "Total aquatic area",
                value = "x",
                showcase = icon("water"),
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


habitats_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        # Add plots when ready
    })
}
