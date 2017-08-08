
shinyUI <- dashboardPage(skin = "purple", title = "Yu-Han Chen",
 
                         dashboardHeader(title="Haircare Products"),
                         
                         ##### dashboardSidebar #####
                         dashboardSidebar(
                           sidebarMenu(
                             menuItem("Results", tabName = "result", icon = icon("pencil")),
                             menuItem("Search", tabName = "search", icon = icon("search")),
                             menuItem("Methodology", tabName = "method", icon = icon("question-circle-o")),
                             menuItem("Datasets", tabName = "dataset", icon = icon("th-list")),
                             br(),
                             menuItem("Contact Yu-Han"),
                             menuItem("LinkedIn", icon = icon("linkedin-square"), href = "https://www.linkedin.com/in/yuhanchen36/"),
                             menuItem("GitHub", icon = icon("github"), href = "https://github.com/yuyuhan0306/Influenster-haircare")
                           )
                         ),
                         
                         ##### dashboardBody #####
                         dashboardBody( 
                           ##### result #####
                           tabItems(
                             tabItem(tabName = "result",  
                                     fluidRow( # General information about the datasets
                                       column(width = 4, valueBox("77,338", "Number of Reviews", color = "maroon", icon = icon("commenting"), width = NULL)),
                                       column(width = 4, valueBox("162", "Number of Products", color = "aqua", icon = icon("shopping-cart"), width = NULL)),
                                       column(width = 4, valueBox("4.49/5.00", "Average Rating Points", color = "green", icon = icon("star"), width = NULL))
                                     ),
                                     
                                     fluidRow(
                                       column(width = 6,
                                         tabBox(side = "left",
                                                selected = "Top Brands",
                                                tabPanel("Top Brands", plotlyOutput("brandpie")),
                                                tabPanel("Comparison Cloud", HTML('<center><img src="comparisoncloud.png"></center>')),
                                                tabPanel("Rating Map", plotlyOutput("ratingmap", height = 350)),
                                                tabPanel("Reviews Map", plotlyOutput("reviewmap", height = 350)),
                                                tabPanel("Analysis", plotlyOutput("graph", height = 350)),
                                                width = NULL) 
                                              ),
                                     
                                     column(width = 6, 
                                            box(title = "Wordcloud", status = "warning",
                                                solidHeader = TRUE, width = NULL, height = NULL,     
                                                inputPanel(
                                                  selectInput("product_type", label = "Haircare Product Type: ", 
                                                              selected="All", c("All","Shampoo", "Conditioner", "Hair Oil")),
                                                  actionButton("update", "Change"),
                                                  sliderInput("freq",
                                                              "Minimum Frequency:",
                                                              min = 1,  max = 50, value = 15),
                                                  sliderInput("max",
                                                              "Maximum Number of Words:",
                                                              min = 1,  max = 300,  value = 100)
                                                ),     
                                                plotOutput("wordcloud"))
                                            ))
                                     ),
                           ##### search #####
                             tabItem(tabName = "search",
                                     box(width = 4,
                                         textInput(inputId = "keyword", label = h4("Find: ")) #, value = ""
                                     ),
                                     fluidRow(
                                       column(width = 12, side = 'center',
                                              DT::dataTableOutput("rec"))
                                     )
                             ),
                           ##### methodology #####
                           tabItem(tabName = "method",
                                   fluidRow(
                                     column(width = 12,
                                            box( title = "Search Engine Methodology", width = NULL, solidHeader = TRUE, status = "primary",
                                                 h2("TF-IDF"),
                                                 h4("Term Frequency–Inverse Document Frequency, a numerical statistic that is intended to reflect how important a word is to a document in a corpus."),
                                                 h4("It is often used as a weighting factor in information retrieval, text mining, and user modeling."),   
                                                 h4("The TF-IDF value increases proportionally to the number of times a word appears in the document, but is often offset by the frequency of the word in the corpus, which helps to adjust for the fact that some words appear more frequently in general."),
                                                 h4("Natural weighting schema, which counts the number of occurrences of a term in a document."),
                                                 br(),
                                                 h2("Cosine Similarity"),
                                                 h4("A measure of similarity between two non-zero vectors of an inner product space that measures the cosine of the angle between them."),
                                                 br(),
                                                 h4(HTML('<left><img src="cosinesimilarity.png"></left>')),
                                                 br(),
                                                 h4("In the case of information retrieval, the cosine similarity of two documents will range from 0 to 1, because the term frequencies (TF-IDF weights) cannot be negative. The angle between two term frequency vectors cannot be greater than 90°.")
                                            )
                                     )
                                   )
                           ),
                           ##### dataset #####
                             tabItem(tabName = "dataset",
                                     fluidRow(
                                       column(width = 12,
                                              br(),     
                                              h4("The datasets are crawled from ", a("Influenster", href = "https://www.influenster.com/", target="_blank"), " , which is a product discovery and reviews platform for consumers.",
                                                 "Influenster has a platform consisting of over 14 million reviews and more than 2 million products for users to discover."),
                                              
                                              h4("I conducted two-level web scraping to obtain top shampoo, conditioner and hair oil products.", 
                                                 "There are ", strong("162"), " haircare products and over ", strong("77,000") ,"comments.",
                                              br(),
                                              h4("All the code is available on my ", a("github", href = "https://github.com/yuyuhan0306/Influenster-haircare", target="_blank"), "."),
                                              br()
                                              ),
                                     fluidRow(
                                       column(4, selectizeInput(inputId = "dataset_selection",  #add dropdown menu for user to sort table
                                                                label = "Show Datasets By:",
                                                                choices = c("Haircare Top Products","Reviews of Top Haircare Products"),
                                                                selected = "Haircare Top Products")),
                                                 downloadButton('downloadData', 'Download')
                                              ),
                                              fluidRow(
                                                box(DT::dataTableOutput("datatable"), width = 12)) #add datatable to user interface
                                       )
                                     )
                             )
                         )
                         )
)