library(plotly)

plot_ly(iris,
        type = "scatter",
        color = ~Species,
        x = ~Petal.Length,
        y = ~Petal.Width,
        width = 750,
        height = 500) %>% 
  layout(title = list(text = "Interactive Plotly chart using `Iris` dataset",
                      xanchor = "right"))
