ui <- fluidPage(
  titlePanel("Predicting Iris Species"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("Petal.Width", label = "Petal.Width:", value = 1.65
                  , min = .1, max = 2.5, step = .01)
      ,sliderInput("Petal.Length", "Petal.Length:", value = 3.5
                   , min = 1, max = 6.9, step = .01)
      ,sliderInput("Sepal.Width", "Sepal.Width:", value = 3
                   , min = 2, max = 4.4, step = .01)
      ,sliderInput("Sepal.Length", "Sepal.Length:", value = 6
                   , min = 4.3, max = 7.9, step = .01)
    ),
    mainPanel(
      tabsetPanel(
      tabPanel(DT::dataTableOutput("pred_table")),
      tabPanel("Scatter Plot", plotOutput("plot")),
      tabPanel("Sepal Width Density Plot", plotOutput("density")),
      tabPanel("Sepal Length Density Plot", plotOutput("density2")),
      tabPanel("Petal Width Density Plot", plotOutput("density3")),
      tabPanel("Petal Length Density Plot", plotOutput("density4"))
    ))
  )
)



