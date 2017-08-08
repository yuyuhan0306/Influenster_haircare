
shinyServer <- function(input, output, session) {  
##### Search Engine #####  
  # Render Data table
  output$rec <- DT::renderDataTable(
     QrySearch(input$keyword)
  ) 

##### Brand Pie Chart #####
  output$brandpie <- renderPlotly({
    trace1 <- list(
      direction = "counterclockwise", 
      labels = c("OTHERS", "BUMBLE AND BUMBLE", "TRESEMMÉ", "NOT YOUR MOTHER'S", "NEXXUS", "CAROL'S DAUGHTER", "KÉRASTASE", "ATISTE", "L'ORÉAL PARIS", "AUSSIE", "SHEAMOISTURE", "GARNIER", "PANTENE", "DOVE", "OGX", "SUAVE", "HERBAL ESSENCES"), 
      labelssrc = "yuyuhan0306:13:868d0d", 
      marker = list(
        colors = c("rgb(255,255,204)", "rgb(161,218,180)", "rgb(65,182,196)", "rgb(44,127,184)", "rgb(8,104,172)", "rgb(37,52,148)"), 
        line = list(color = "rgb(255, 255, 255)")
      ), 
      name = "B", 
      textinfo = "label+percent", 
      textposition = "inside", 
      type = "pie", 
      uid = "5ae3f7", 
      values = c("45", "3", "3", "3", "3", "3", "4", "5", "6", "6", "7", "9", "10", "10", "12", "13", "14"), 
      valuessrc = "yuyuhan0306:13:f30f0f"
    )
    data <- list(trace1)
    layout <- list(
      annotations = list(
        list(
          x = -0.198701298701, 
          y = -0.359090909091, 
          ax = 38, 
          ay = 0, 
          font = list(
            family = "Droid Sans, sans-serif", 
            size = 11
          ), 
          showarrow = FALSE, 
          text = "<br>", 
          xanchor = "left", 
          yanchor = "bottom"
        )
      ), 
      autosize = FALSE, 
      height = 350, 
      hovermode = "closest", 
      legend = list(
        x = 0.902354317467, 
        y = 1
      ), 
      margin = list(
        r = 0, 
        t = 50, 
        b = 10, 
        l = 0, 
        pad = 0
      ), 
      paper_bgcolor = "rgb(255, 255, 255)", 
      showlegend = TRUE, 
      title = "Most Popular Brands", 
      titlefont = list(size = 20), 
      width = 550
    )
    plot_ly() %>% 
      add_trace(p, direction=trace1$direction, labels=trace1$labels, labelssrc=trace1$labelssrc, marker=trace1$marker, name=trace1$name, textinfo=trace1$textinfo, textposition=trace1$textposition, type=trace1$type, uid=trace1$uid, values=trace1$values, valuessrc=trace1$valuessrc) %>% 
      layout(p, annotations=layout$annotations, autosize=layout$autosize, height=layout$height, hovermode=layout$hovermode, margin=layout$margin, paper_bgcolor=layout$paper_bgcolor, showlegend=layout$showlegend, title=layout$title, titlefont=layout$titlefont, width=layout$width)
  })

##### Avg Rating Map #####
  output$ratingmap <- renderPlotly({
    trace1 <- list(
      z = c("4.24", "4.61", "4.51", "4.49", "4.46", "4.51", "4.53", "4.43", "4.51", "4.51", "4.54", "4.55", "4.38", "4.38", "4.48", "4.45", "4.35", "4.5", "4.39", "4.43", "4.47", "4.44", "4.42", "4.45", "4.51", "4.57", "4.73", "4.49", "4.44", "4.46", "4.54", "4.54", "4.5", "4.56", "4.52", "4.47", "4.57", "4.48", "4.51", "4.49", "4.47", "4.42", "4.49", "4.51", "4.42", "4.49", "4.36", "4.47", "4.52", "4.46", "4.44"), 
      autocolorscale = FALSE, 
      colorbar = list(
        x = 0.901638617988, 
        y = 0.506253908693, 
        title = "Rating"
      ), 
      colorscale = list(c(0, "rgb(255,255,204)"),list(0.35, "rgb(161,218,180)"),list(0.5, "rgb(65,182,196)"),list(0.6, "rgb(44,127,184)"),list(0.7, "rgb(8,104,172)"),list(1, "rgb(37,52,148)")), 
      locationmode = "USA-states", 
      locations = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"), 
      locationssrc = "yuyuhan0306:8:8f10cc", 
      name = "star", 
      type = "choropleth", 
      uid = "9e44d2", 
      zauto = TRUE, 
      zmax = 4.73, 
      zmin = 4.24, 
      zsrc = "yuyuhan0306:8:3558f2"
    )
    data <- list(trace1)
    layout <- list(
      autosize = FALSE, 
      dragmode = "zoom", 
      geo = list(
        bgcolor = "#fff", 
        domain = list(
          x = c(0, 1), 
          y = c(0, 1)
        ), 
        lataxis = list(
          dtick = 10, 
          range = c(-90, 90), 
          showgrid = FALSE, 
          tick0 = -90
        ), 
        lonaxis = list(
          dtick = 30, 
          range = c(-120, 90), 
          showgrid = FALSE, 
          tick0 = -90
        ), 
        projection = list(
          scale = 1, 
          type = "albers usa"
        ), 
        resolution = 110, 
        scope = "usa", 
        showcoastlines = FALSE, 
        showcountries = FALSE, 
        showframe = FALSE, 
        showlakes = FALSE, 
        showland = FALSE, 
        showocean = FALSE, 
        showrivers = FALSE, 
        showsubunits = TRUE
      ), 
      height = 350, 
      hidesources = FALSE, 
      hovermode = "closest", 
      legend = list(borderwidth = 5), 
      margin = list(
        r = 0, 
        t = 40, 
        b = 10, 
        l = 0, 
        pad = 0
      ), 
      paper_bgcolor = "rgb(255, 255, 255)", 
      separators = ".,", 
      showlegend = TRUE, 
      smith = FALSE, 
      title = "Average Haircare Products Rating", 
      titlefont = list(size = 20), 
      width = 550
    )
    plot_ly() %>% 
      add_trace(z=trace1$z, autocolorscale=trace1$autocolorscale, colorbar=trace1$colorbar, colorscale=trace1$colorscale, locationmode=trace1$locationmode, locations=trace1$locations, locationssrc=trace1$locationssrc, name=trace1$name, type=trace1$type, uid=trace1$uid, zauto=trace1$zauto, zmax=trace1$zmax, zmin=trace1$zmin, zsrc=trace1$zsrc) %>% 
      layout(autosize=layout$autosize, dragmode=layout$dragmode, geo=layout$geo, height=layout$height, hidesources=layout$hidesources, hovermode=layout$hovermode, legend=layout$legend, margin=layout$margin, paper_bgcolor=layout$paper_bgcolor, separators=layout$separators, showlegend=layout$showlegend, smith=layout$smith, title=layout$title, titlefont=layout$titlefont, width=layout$width)
  })
  
  # output$click1 <- renderPrint({
  #   d <- event_data("plotly_click")
  #   if (is.null(d)) "Click on a state to view event data" else d
  # })
    
##### Total Reviews Map #####
  output$reviewmap <- renderPlotly({
    trace1 <- list(
      z = c("65", "887", "512", "799", "4740", "372", "469", "74", "139", "3898", "1606", "85", "275", "180", "1523", "916", "297", "1208", "565", "822", "813", "133", "1475", "478", "750", "469", "47", "1476", "54", "144", "127", "1134", "188", "361", "2818", "1757", "497", "409", "2028", "162", "733", "54", "1067", "3787", "317", "1135", "53", "765", "626", "456", "41"), 
      autocolorscale = FALSE, 
      colorbar = list(
        x = 0.90488372093, 
        y = 0.518099547511, 
        title = "# of Reviews"
      ), 
      colorscale = list(c(0, "rgb(54,50,153)"),list(0.35, "rgb(17,123,215)"),list(0.5, "rgb(37,180,167)"),list(0.6, "rgb(134,191,118)"),list(0.7, "rgb(249,210,41)"),list(1, "rgb(244,236,21)")), 
      locationmode = "USA-states", 
      locations = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"), 
      locationssrc = "yuyuhan0306:9:e2d417", 
      name = "content", 
      type = "choropleth", 
      uid = "2b8578", 
      zauto = TRUE, 
      zmax = 4740, 
      zmin = 41, 
      zsrc = "yuyuhan0306:9:e1b22f"
    )
    data <- list(trace1)
    layout <- list(
      autosize = FALSE, 
      geo = list(
        lonaxis = list(range = c(-120, 90)), 
        scope = "usa"
      ), 
      height = 350, 
      hovermode = "closest", 
      margin = list(
        r = 0, 
        t = 40, 
        b = 10, 
        l = 0
      ), 
      paper_bgcolor = "rgb(255, 255, 255)", 
      title = "Total Number of Reviews", 
      titlefont = list(size = 20), 
      width = 550
    )
    plot_ly() %>% 
      add_trace(p, z=trace1$z, autocolorscale=trace1$autocolorscale, colorbar=trace1$colorbar, colorscale=trace1$colorscale, locationmode=trace1$locationmode, locations=trace1$locations, locationssrc=trace1$locationssrc, name=trace1$name, type=trace1$type, uid=trace1$uid, zauto=trace1$zauto, zmax=trace1$zmax, zmin=trace1$zmin, zsrc=trace1$zsrc) %>% 
      layout(p, autosize=layout$autosize, geo=layout$geo, height=layout$height, hovermode=layout$hovermode, margin=layout$margin, paper_bgcolor=layout$paper_bgcolor, title=layout$title, titlefont=layout$titlefont, width=layout$width)
    
})
  
##### Reviews Count/Rating #####
  output$graph <- renderPlotly({
  trace1 <- list(
    x = c(4.44, 4.56, 4.48, 4.45, 4.55, 4.37, 4.43, 4.65, 4.71, 4.67, 4.35, 4.63, 4.52, 4.62, 4.35, 4.4, 4.43, 4.66, 4.77, 4.53, 4.58, 4.48, 4.43, 4.71), 
    y = c(2061, 1208, 535, 2801, 2000, 1598, 3822, 171, 981, 375, 2022, 432, 561, 494, 671, 5167, 1249, 959, 514, 423, 2047, 2375, 2505, 530), 
    hoverinfo = "x+y+text", 
    marker = list(color = "rgb(214, 39, 40)"), 
    mode = "markers", 
    opacity = 1, 
    text = c("ATISTE", "AUSSIE", "CLAIROL", "DOVE", "GARNIER", "HEAD & SHOULDERS", "HERBAL ESSENCES", "IT'S A 10", "JOHNSON & JOHNSON", "JOICO", "L'ORÉAL PARIS", "LIVE CLEAN", "LUSH", "MOROCCANOIL", "NOT YOUR MOTHER'S", "OGX", "PANTENE", "PAUL MITCHELL", "PUREOLOG", "REDKEN", "SHEAMOISTURE", "SUAVE", "TRESEMMÉ", "URT'S BEES"), 
    textsrc = "yuyuhan0306:5:c6bd02", 
    type = "scatter", 
    uid = "602944", 
    xsrc = "yuyuhan0306:5:cca14a", 
    ysrc = "yuyuhan0306:5:2c9980"
  )
  data <- list(trace1)
  layout <- list(
    autosize = FALSE, 
    height = 350, 
    margin = list(
      r = 50, 
      t = 80, 
      b = 80, 
      l = 70
    ), 
    paper_bgcolor = "rgb(255, 255, 255)", 
    plot_bgcolor = "rgb(255, 255, 255)", 
    showlegend = FALSE, 
    title = "Discussion vs Rating of the Brand", 
    width = 550, 
    xaxis = list(
      autorange = TRUE, 
      fixedrange = TRUE, 
      range = c(4.32205533597, 4.79794466403), 
      ticks = "inside", 
      title = "Rating", 
      type = "linear"
    ), 
    yaxis = list(
      autorange = TRUE, 
      fixedrange = TRUE, 
      range = c(-233.874617737, 5571.87461774), 
      title = "Number of Reviews", 
      type = "linear"
    )
  )
  plot_ly() %>% 
    add_trace(p, x=trace1$x, y=trace1$y, hoverinfo=trace1$hoverinfo, marker=trace1$marker, mode=trace1$mode, opacity=trace1$opacity, text=trace1$text, textsrc=trace1$textsrc, type=trace1$type, uid=trace1$uid, xsrc=trace1$xsrc, ysrc=trace1$ysrc) %>% 
    layout(p, autosize=layout$autosize, height=layout$height, margin=layout$margin, paper_bgcolor=layout$paper_bgcolor, plot_bgcolor=layout$plot_bgcolor, showlegend=layout$showlegend, title=layout$title, width=layout$width, xaxis=layout$xaxis, yaxis=layout$yaxis)
  })
##### Comparison Cloud #####
# using png
##### Wordclouds #####
  terms <- reactive({
    # Change when the "update" button is pressed
    input$update
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$product_type)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$wordcloud <- renderPlot({

    if (input$product_type == "All"){
      hair_wordcloud <- reviewCorpus 
      set.seed(100)
    } else if(input$product_type == "Shampoo") {
      hair_wordcloud <- shampooCorpus
      set.seed(123)
    } else if (input$product_type == "Conditioner"){
      hair_wordcloud <- conditionerCorpus
      set.seed(234)
    } else {
      hair_wordcloud <- oilCorpus
      set.seed(345)
    } 

    wordcloud_rep(hair_wordcloud, max.words = input$max, min.freq = input$freq, colors = brewer.pal(11, "Spectral"),res=350)
})
  

##### Datasets #####
  datasetInput <- reactive({
    switch(input$dataset_selection,
           "Haircare Top Products" = top_products,
           "Reviews of Top Haircare Products" = products_review)
  })
  
  output$datatable <- DT::renderDataTable({
    datasetInput()
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset_selection, '.csv', sep='') },
    content = function(file) {
      write.csv(datasetInput(), file)
    }
  )
}
