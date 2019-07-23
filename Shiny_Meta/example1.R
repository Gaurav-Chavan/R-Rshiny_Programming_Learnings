library(shiny)
library(shinymeta)

ui <- fluidPage(
  selectInput("var", label = "Choose a variable", choices = names(cars)),
  verbatimTextOutput("Summary"),
  verbatimTextOutput("code")
)

server <- function(input, output) {
  var <- metaReactive({
    cars[[!!input$var]]
  })
  output$Summary <- metaRender(renderPrint, {
    summary(!!var())
  })
  output$code <- renderPrint({
    expandChain(output$Summary())
  })
}

shinyApp(ui, server)