#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(NLP)
library(tm)
library(RWeka)
library(data.table)

unigramlist <- readRDS("unigram.Rda")
bigramlist <- readRDS("bigram.Rda")
trigramlist <- readRDS("trigram.Rda")
quadgramlist <- readRDS("quadgram.Rda")

# prediction function

wordproc <- function(sentence){
  value = "next word is..."
  sen = unlist(strsplit(sentence,' '))
  if(length(sen)>=3){
    value = quadgram(sen[(length(sen)-2):length(sen)])
  }

  if(is.null(value)||length(sen)==2){
    value = trigram(sen[(length(sen)-1):length(sen)])

  }
  if(is.null(value)||length(sen)==1){
    value = bigram(sen[length(sen)])
  }
  if(is.null(value)){
   r.number = runif(1, min=0, max=20)
   k<-unigramlist$unigram
   value = as.String(k[r.number])
  }

  return(value)
}

quadgram <- function(fourg){
  four <- paste(fourg,collapse = ' ')
  foursum <- data.frame(quadgram="test",frequency=0)
  k <- trigramlist[trigram==four]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)

  for(string0 in unigramlist$unigram){
    text = paste(four,string0)
    found <- quadgramlist[quadgram==text]
    n<- as.numeric(found$frequency)

    if(length(n)!=0){
      foursum <- rbind(foursum,found)

    }
  }
  if(nrow(foursum)==1) return(NULL)
  foursum <- foursum[order(-frequency)]
  sen <- unlist(strsplit(as.String(foursum[1,fourgram]),' '))
  return (sen[length(sen)])
}

trigram <- function(threeg){
  three <- paste(threeg,collapse = ' ')
  threesum <- data.frame(trigram="test",frequency=0)
  k <- bigramlist[bigram==three]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)

  for(string0 in unigramlist$unigram){
    text = paste(three,string0)
    found <- trigramlist[trigram==text]
    n<- as.numeric(found$frequency)

    if(length(n)!=0){
      threesum <- rbind(threesum,found)

    }
  }
  if(nrow(threesum)==1) return(NULL)
  threesum <- threesum[order(-frequency)]
  sen <- unlist(strsplit(as.String(threesum[1,trigram]),' '))
  return (sen[length(sen)])
}

bigram <- function(twog){
  two <- paste(twog,collapse = ' ')
  twosum <- data.frame(bigram="test",frequency=0)
  k <- unigramlist[unigram==two]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)

  for(string0 in unigramlist$unigram){
    text = paste(two,string0)
    found <- bigramlist[bigram==text]
    n<- as.numeric(found$frequency)

    if(length(n)!=0){
      twosum <- rbind(twosum,found)

    }
  }

  if(nrow(twosum)==1) return(NULL)
  twosum <- twosum[order(-frequency)]

  sen <- unlist(strsplit(as.String(twosum[1,bigram]),' '))
  return (sen[length(sen)])
}



# Define server logic required to provide output
shinyServer(function(input, output) {
   
  output$inputValue <- renderPrint({input$inputText})
  output$prediction <- renderPrint({wordproc(input$inputText)})  
})
