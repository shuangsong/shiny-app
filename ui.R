library(shiny)
library(ggplot2)
library(markdown)
shinyUI(navbarPage("Navigation bar",
                   tabPanel("page1-Diamonds selection table",
                            sidebarLayout(
                                    sidebarPanel(
                                            
                                            selectInput("cu", "Cut", c("all", unique(as.character(diamonds$cut)))
                                            ),
                                            selectInput("col", "Color", c("all", unique(as.character(diamonds$color)))
                                            ),
                                            selectInput("clar", "Clarity", c("all", unique(as.character(diamonds$clarity)))
                                            ),
                                            sliderInput("ca", "Carat", min=0.2, max=5.01, value=c(0.31,4.2 )
                                            ),
                                            sliderInput("de", "Depth", min=43, max=79, value=c(43, 62.8)
                                            ),
                                            sliderInput("ta", "Table", min=43, max=95, value=c(43,58)
                                            ),
                                            submitButton("Update")
                                            ,
                                            helpText("The select box acts like filter,gives you the table you want to filt. The slider bar will filter the range you want. You can 
                                                     slide it to see the range of the variable you want.
                                                     Don't forget to clikc Update button because it 
                                                     returns the table on the right of your screen")),
                                    
                                    mainPanel(
                                            
                                            h4("Diamonds table"),
                                            dataTableOutput(outputId="table")
                                            
                                            
                                    )
                            )
                   ),
                   tabPanel("page2-Exploratory diamonds analysis",
                            sidebarLayout(
                                    sidebarPanel(
                                            selectInput("x","X",names(diamonds[sapply(diamonds, is.numeric)]
                                            )),
                                            selectInput("y","Y",names(diamonds[sapply(diamonds, is.numeric)]
                                            )),
                                            selectInput("facet","Facet Column", c("None", names(diamonds[sapply(diamonds, is.factor)])
                                            )),
                                            selectInput("color","Color", c("None", names(diamonds[sapply(diamonds, is.factor)])
                                            )),
                                            checkboxInput("title", "Title"),
                                            checkboxInput("theme", "Theme Background"),
                                            numericInput("num","Input carat to convert to gram below",value=1),
                                            hr(),
                                            fluidRow(column(3,verbatimTextOutput("value"))),
                                            submitButton("Update"),
                                            helpText("By selecting x (x-axis) and y (y-axis) you can determine
                                                     x and y axis of the plot, meanwhile by selecting facet you can 
                                                     detemrine facet ( by diamonds variables). Enter number of carat to convert to 
                                                     gram and the gram will show below the textinput button. note: 1 carat=0.2 gram")),
                                    mainPanel(
                                            h4("Diamonds plot"),
                                            plotOutput("plot")
                                            
                                            )
                            ))))
                  
     