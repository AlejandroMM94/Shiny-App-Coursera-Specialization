suppressWarnings(library(shiny))
suppressWarnings(library(shinythemes))
suppressWarnings(library(markdown))
shinyUI(navbarPage("NeWorPred: Next Word Prediction Application",
                   theme = shinytheme("spacelab"),
                   tabPanel("Predict the Next Word",
                            img(src = "./headers.png", style="display: block; margin-left: auto; margin-right: auto"),
                            br(),
                            titlePanel("Hello there!! This is NeWorPred Application. Enjoy your visit"),
                            # Sidebar
                              sidebarLayout(
                              sidebarPanel(
                                 h2("Input Words", style = "color:blue"),
                                textInput("inputString", "Enter a word or phrase here",value = "", placeholder = "Enter text here"),
                                img(src = "./pinki.png", style="display: block; margin-left: auto; margin-right: auto"),
                                ),
                              mainPanel(
                                  h2("Predicted Next Word", style = "color:blue"),
                                  verbatimTextOutput("prediction"),
                                  br(),
                                  strong("Note:"),
                                  textOutput('text2')
                              )
                              )
                             
                  ),
                   tabPanel("About",
                            mainPanel(
                              img(src = "./headers.png"),
                              includeMarkdown("about.md")
                            )
                   )
)
)