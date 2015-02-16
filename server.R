library(shiny)
library(ggplot2)
library(datasets)

shinyServer(function(input, output) {
        output$table <- renderDataTable({
                data <- diamonds
                
                if (input$cu != "all"){
                        data <- data[data$cut == input$cu,]
                }
                if (input$col != "all"){
                        data <- data[data$color == input$col,]
                }
                if (input$clar != "all"){
                        data <- data[data$clarity == input$clar,]
                }
                if (input$ca >min(data$carat) & input$ca< max(data$carat)){
                    data<-data[data$carat>input$ca[1]&data$carat<input$ca[2],]
                }
                if (input$de >min(input$de) & input$de< max(input$de)){
                    data<-data[data$depth>input$de[1]&data$depth<input$de[2],]
                }
                if (input$ta >min(input$ta) & input$ta< max(input$ta)){
                    data<-data[data$table>input$ta[1]&data$table<input$ta[2],]
                }
                
                data
        
        })
        
        output$plot <- renderPlot({
                data<-diamonds
                p<-ggplot(data, aes_string(x=input$x, y=input$y),
                environment = environment())+ geom_point()
        
                if (input$facet != "None")
                        p<-p+facet_grid(paste(". ~",input$facet))
                if (input$color !="None")
                        p <-p+aes_string(color=input$color)
                if (input$title)
                        p<-p+ggtitle("Explore relationship in diamonds")
                if (input$theme)
                        p<-p+theme_bw()
                print(p)
        })
                
        output$value <- renderPrint({ input$num * 0.2 })

        
})

