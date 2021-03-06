library(tm)
library(RWeka)
data_twitter <- readLines("./Coursera-SwiftKey/final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul = TRUE)
data_blogs <- readLines("./Coursera-SwiftKey/final/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul = TRUE)
data_news <- readLines("./Coursera-SwiftKey/final/en_US/en_US.news.txt", encoding = "UTF-8", skipNul = TRUE)

set.seed(1967)
sampleBlog <- sample(data_blogs, size = 1500)
sampleNews <- sample(data_news, size = 200)
sampleTwitter <- sample(data_twitter, size = 3500)
sample <- c(sampleBlog, sampleNews, sampleTwitter)
corpus  <- VCorpus(VectorSource(sample))

toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
corpus <- tm_map(corpus, toSpace, "/|@|//|$|:|:)|*|&|!|?|_|-|#|")
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)


text1 <- TermDocumentMatrix(corpus)
matrix1 <- as.matrix(text1)
sum1 <- rowSums(matrix1)
freq1 <- sort(sum1, decreasing = TRUE)
table1 <- data.frame(words = names(freq1), count = freq1)


BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
text2 <- TermDocumentMatrix(corpus, control = list(tokenize = BigramTokenizer))
matrix2 <- as.matrix(text2)
sum2 <- rowSums(matrix2)
freq2 <- sort(sum2, decreasing = TRUE)
table2 <- data.frame(words = names(freq2), count = freq2)

bigram <- data.frame(rows=rownames(table2),count=table2$count)
bigram$rows <- as.character(bigram$rows)
bigram_split <- strsplit(as.character(bigram$rows),split=" ")
bigram <- transform(bigram,first = sapply(bigram_split,"[[",1),second = sapply(bigram_split,"[[",2))
bigram <- data.frame(unigram = bigram$first,bigram = bigram$second,freq = bigram$count,stringsAsFactors=FALSE)
write.csv(bigram[bigram$freq > 1,],"./ShinyApp/bigram.csv",row.names=F)
bigram <- read.csv("./ShinyApp/bigram.csv",stringsAsFactors = F)
saveRDS(bigram,"./ShinyApp/bigram.RData")


TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
text3 <- TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer))
matrix3 <- as.matrix(text3)
sum3 <- rowSums(matrix3)
freq3 <- sort(sum3, decreasing = TRUE)
table3 <- data.frame(words = names(freq3), count = freq3)

trigram <- data.frame(rows=rownames(table3),count=table3$count)
trigram$rows <- as.character(trigram$rows)
trigram_split <- strsplit(as.character(trigram$rows),split=" ")
trigram <- transform(trigram,first = sapply(trigram_split,"[[",1),second = sapply(trigram_split,"[[",2),third = sapply(trigram_split,"[[",3))
trigram <- data.frame(unigram = trigram$first,bigram = trigram$second, trigram = trigram$third, freq = trigram$count,stringsAsFactors=FALSE)
write.csv(trigram[trigram$freq > 1,],"./ShinyApp/trigram.csv",row.names=F)
trigram <- read.csv("./ShinyApp/trigram.csv",stringsAsFactors = F)
saveRDS(trigram,"./ShinyApp/trigram.RData")


QuatrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
text4 <- TermDocumentMatrix(corpus, control = list(tokenize = QuatrigramTokenizer))
matrix4 <- as.matrix(text4)
sum4 <- rowSums(matrix4)
freq4 <- sort(sum4, decreasing = TRUE)
table4 <- data.frame(words = names(freq4), count = freq4)

quadgram <- data.frame(rows=rownames(table4),count=table4$count)
quadgram$rows <- as.character(quadgram$rows)
quadgram_split <- strsplit(as.character(quadgram$rows),split=" ")
quadgram <- transform(quadgram,first = sapply(quadgram_split,"[[",1),second = sapply(quadgram_split,"[[",2),third = sapply(quadgram_split,"[[",3), fourth = sapply(quadgram_split,"[[",4))
quadgram <- data.frame(unigram = quadgram$first,bigram = quadgram$second, trigram = quadgram$third, quadgram = quadgram$fourth, freq = quadgram$count,stringsAsFactors=FALSE)
write.csv(quadgram[quadgram$freq > 1,],"./ShinyApp/quadgram.csv",row.names=F)
quadgram <- read.csv("./ShinyApp/quadgram.csv",stringsAsFactors = F)
saveRDS(quadgram,"./ShinyApp/quadgram.RData")