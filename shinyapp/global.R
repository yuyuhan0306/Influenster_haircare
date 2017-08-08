library(shinydashboard)
library(dplyr)
library(plotly)
library(tidytext)
library(SnowballC)
library(tm)
library(wordcloud)
library(wordcloud2)
library(memoise)

##### load datasets #####
load("products_influenster.Rda")
load("top_products.Rda")
load("products_review.Rda")
load("reviews_cloud.Rda")
load("rev_shampoo.Rda")
load("rev_conditioner.Rda")
load("rev_oil.Rda")
load("corpus.Rda")


##### Search engine #####
docList <- as.list(products_influenster$product_name)
N.docs <- length(docList)
QrySearch <- function(queryTerm) {
  
  # Record starting time to measure your search engine performance
  start.time <- Sys.time()
  
  # store docs in Corpus class which is a fundamental data structure in text mining
  my.docs <- VectorSource(c(docList, queryTerm))
  
  
  # Transform/standaridze docs to get ready for analysis
  my.corpus <- VCorpus(my.docs) %>% 
    tm_map(stemDocument) %>%
    tm_map(content_transformer(tolower)) %>% 
    tm_map(removeWords,stopwords("english")) %>%
    tm_map(stripWhitespace)
  
  # Store docs into a term document matrix where rows=terms and cols=docs
  # Normalize term counts by applying TF-IDF weightings
  term.doc.matrix.stm <- TermDocumentMatrix(my.corpus,
                                            control=list(
                                              weighting=function(x) weightSMART(x,spec="nnn"), #ltc
                                              wordLengths=c(1,Inf)))
  
  # Transform term document matrix into a dataframe
  term.doc.matrix <- tidy(term.doc.matrix.stm) %>% 
    group_by(document) %>% 
    mutate(vtrLen=sqrt(sum(count^2))) %>% 
    mutate(count=count/vtrLen) %>% 
    ungroup() %>% 
    select(term:count)
  docMatrix <- term.doc.matrix %>% 
    mutate(document=as.numeric(document)) %>% 
    filter(document<N.docs+1)
  qryMatrix <- term.doc.matrix %>% 
    mutate(document=as.numeric(document)) %>% 
    filter(document>=N.docs+1)
  
  
  # Calcualte top 5 results by cosine similarity
  searchRes <- docMatrix %>% 
    inner_join(qryMatrix,by=c("term"="term"),
               suffix=c(".doc",".query")) %>% 
    mutate(termScore=round(count.doc*count.query,4)) %>% 
    group_by(document.query,document.doc) %>% 
    summarise(cosine_similarity=sum(termScore)) %>% 
    filter(row_number(desc(cosine_similarity))<=5) %>% 
    arrange(desc(cosine_similarity)) %>% 
    left_join(products_influenster,by=c("document.doc"="V1")) %>% 
    ungroup() %>% 
    rename(Result=product_name) %>% 
    select(Result,cosine_similarity,overall_rating,reviews_count) %>% 
    data.frame()
  
  
  # Record when it stops and take the difference
  end.time <- Sys.time()
  time.taken <- round(end.time - start.time,4)
  print(paste("Used",time.taken,"seconds"))
  
  return(searchRes)
  
}

##### Wordcloud #####
# reviewCorpus <- Corpus(VectorSource(reviews_cloud$content)) %>%
#   tm_map(removePunctuation) %>%
#   tm_map(stripWhitespace) %>%
#   tm_map(tolower) %>%
#   tm_map(removeNumbers) %>%
#   tm_map(removeWords, stopwords('english')) %>%
#   tm_map(removeWords, c('hair','product','shampoo','shampoos','conditioner','conditioners',
#                         'oil','love','like','smells','make','makes','ends','use','used','put',
#                         'great','good','really','just','one','let','goes'))
# 
# shampooCorpus <- Corpus(VectorSource(rev_shampoo$V2)) %>%
#   tm_map(removePunctuation) %>%
#   tm_map(stripWhitespace) %>%
#   tm_map(tolower) %>%
#   tm_map(removeNumbers) %>%
#   tm_map(removeWords, stopwords('english')) 
# 
# conditionerCorpus <- Corpus(VectorSource(rev_conditioner$V2)) %>%
#   tm_map(removePunctuation) %>%
#   tm_map(stripWhitespace) %>%
#   tm_map(tolower) %>%
#   tm_map(removeNumbers) %>%
#   tm_map(removeWords, stopwords('english'))
# 
# oilCorpus <- Corpus(VectorSource(rev_oil$V2)) %>%
#   tm_map(removePunctuation) %>%
#   tm_map(stripWhitespace) %>%
#   tm_map(tolower) %>%
#   tm_map(removeNumbers) %>%
#   tm_map(removeWords, stopwords('english'))
