library("shiny")
library("threejs")
source("exoPlanetExplorer.R")

set.seed(1)
#if(!exists("example_data")) example_data <- matrix(runif(50*3),ncol=3)

if(!exists("stars_data")){  
  stars_data <- getStarData()
}
  

shinyServer(function(input, output) {
  
  output$scatterplot <- renderScatterplotThree({
    num.ticks <- input$nticks
    n<-1000
    if(num.ticks==0) num.ticks <- NULL
    else num.ticks <- rep(num.ticks,3)
    color <- rep(rainbow(input$colors),length.out=nrow(stars_data))
    color<-rep(rainbow(input$colors),length.out=nrow(stars_data))
    sizes <- rep(c(0.5, 1, 2)[1:input$sizes], length.out=nrow(stars_data))
    labs <- sprintf("x=%.2f, y=%.2f, z=%.2f", stars_data$x, stars_data$y, stars_data$z)
    earthZ<-rep(0,length.out=n)
    earthY<-rep(0,length.out=n)
    earthX<-seq(0,4000,length.out=n)
    color<-c( rep('black',n), color)
    x<-c(earthX,stars_data$x)
    y<-c(earthY,stars_data$y)
    z<-c(earthZ,stars_data$z)
    sizes<-c(rep(0.02,n), sizes)
    scatterplot3js(
                   x, 
                   y, 
                   z,
                   num.ticks=num.ticks,
                   color=color,
                   size=sizes,
                   labels=labs,
                   label.margin="80px 10px 10px 10px",
                   renderer=input$renderer,
                   grid=input$grid)
  })
})
