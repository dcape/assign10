server <- function(input, output){
  
  Preds <- reactive({
    generatePreds(
      Petal.Width = input$Petal.Width
      ,Petal.Length = input$Petal.Length
      ,Sepal.Width = input$Sepal.Width
      ,Sepal.Length = input$Sepal.Length
    )
  })
  
  output$pred_table <- DT::renderDataTable({
    Preds() %>%
      datatable() %>%
      formatPercentage(columns = 'preds', digits = 2)
  })
  
  scatter <- ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width)) 
  output$plot <- renderPlot({ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width)) 
  scatter + geom_point(aes(color=Species)) +
    xlab("Sepal Length") +  ylab("Sepal Width") +
    geom_vline(aes(xintercept = mean(Sepal.Length)), color = "red", linetype = "dashed") +
    geom_hline(aes(yintercept = mean(Sepal.Width)), color = "red", linetype = "dashed") +
    ggtitle("Sepal Length-Width")
  })
  
  density <- ggplot(data=iris, aes(x=Sepal.Width, fill=Species))
  output$density <- renderPlot({ggplot(data=iris, aes(x=Sepal.Width, fill=Species))
  density + geom_density(stat="density", alpha=I(0.2)) +
    xlab("Sepal Width") +  ylab("Density") + ggtitle("Density Curve of Sepal Width")
  })
  
  density2 <- ggplot(data=iris, aes(x=Sepal.Length, fill=Species))
  output$density2 <- renderPlot({ggplot(data=iris, aes(x=Sepal.Length, fill=Species))
    density2 + geom_density(stat="density", alpha=I(0.2)) +
      xlab("Sepal Length") +  ylab("Density") + ggtitle("Density Curve of Sepal Length")
  })
  
  density3 <- ggplot(data=iris, aes(x=Petal.Width, fill=Species))
  output$density3 <- renderPlot({ggplot(data=iris, aes(x=Petal.Width, fill=Species))
    density3 + geom_density(stat="density", alpha=I(0.2)) +
      xlab("Petal Width") +  ylab("Density") + ggtitle("Density Curve of Petal Width")
  })
  
  density4 <- ggplot(data=iris, aes(x=Petal.Length, fill=Species))
  output$density4 <- renderPlot({ggplot(data=iris, aes(x=Petal.Length, fill=Species))
    density4 + geom_density(stat="density", alpha=I(0.2)) +
      xlab("Petal Length") +  ylab("Density") + ggtitle("Density Curve of Petal Length")
  })
  
}


