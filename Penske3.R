library(tm)
library(wordcloud)
library(stringr)
library(kableExtra)
library(httr)

# Assign corpus of Penske reviews to folder

folder <- "C:/Users/narce/OneDrive/Documents/GitHub/Penske/Penske/corpus"

# Confirm the contents of the folder
list.files(path=folder, pattern="*.txt")

# Create character vector of the four file names
filelist <- list.files(path=folder, pattern="*.txt")
filelist
str(filelist)

# Create a separate file path for each element
filelist <-paste(folder, "\\", filelist, sep="")

# Import each file as a character vector
lapply(filelist, FUN=readLines) 

# Assigns a new vector to filelistA
filelistA <- lapply(filelist, FUN=readLines)

lapply(filelistA, FUN = paste, collapse=" ")

corpus <-lapply(filelistA, FUN = paste, collapse=" ")

corpus

# Removes punctuations
corpus2 <- gsub(pattern = "\\W", replace=" ", corpus)

# Removes numbers
corpus2 <- gsub(pattern = "\\d", replacement = " ", corpus2)

# Makes text lowercase
corpus2<-tolower(corpus2)

# Removes stopwords (and, the, a...)
corpus2 <- removeWords(corpus2, stopwords("english"))

# Removes single character text
corpus2 < gsub(pattern = "\\b[A-z]\\b{1}", replace=" ", corpus2)

# Removes white space
corpus2 <- stripWhitespace(corpus2)

# Creates a wordcloud visualization of the most used words in the corpus 
wordcloud(corpus2, random.order = FALSE, colors = rainbow(3))

# Creates a corpus
corpus3 <- Corpus(VectorSource(corpus2))
summary(corpus3)

# Creates a Term document matrix
tdm <- TermDocumentMatrix(corpus3)
tdm

# Creates the matrix
as.matrix(tdm)

viewmatrix <- as.matrix(tdm)
corpus_sort<-(viewmatrix)

corpus_sort <- read.table
corpus_sort1 <-sort(corpus_sort, c(1:4), decreasing = TRUE)
View(corpus_sort)
corpus_sort[order(c("Read1", "Malb", "Read2", "Baker"))]


# Changes the names of the columns (Read1 = Reading, PA, Malb = Malborough, MA, Read2 - Reading, PA, Baker = Bakersfield, CA)
colnames(viewmatrix) <- c("Read1", "Malb", "Read2", "Baker")
viewmatrix

# Creates a comparision wordcloud the illustrates the most used term in each of the four documents. 
# Insight & Analysis - "home depot" stands out in Malb, "truck" and "police" are significant in Read1,
# "damages" "insurance" and "roadway" in Read2, while "husband", "two" and "vehicle" are the prominent terms in Baker.
comparison.cloud(viewmatrix)

# Import opinion lexicons
opinion.lexicon.pos <- scan("positive-words.txt", what="character", comment.char = ";")

opinion.lexicon.neg <- scan("negative-words.txt", what="character", comment.char = ";")

# Creates a bag of words for each document in the corpus.
corpus4 <- str_split(corpus2, pattern="\\s+")
corpus4

# Matches the bag of words to the positive lexicon of words. Doc1 = 3, Doc2 = 10, Doc3 = 5, Doc4 = 4. 
lapply(corpus4, function(x) { sum(!is.na(match(x, opinion.lexicon.pos)))})

# Matches the bag of words to the negative lexicon of words. Doc1 = 10, Doc2 = 7, Doc3 = 12, Doc4 = 14 
lapply(corpus4, function(x) { sum(!is.na(match(x, opinion.lexicon.neg)))})

# Calculates the sum totals of Positive sentiments vs negative sentiments in the corpus. Doc1 = -7, Doc2 = 3, Doc3 = -7, Doc4 = -10. 
lapply(corpus4, function(x) { sum(!is.na(match(x, opinion.lexicon.pos))) - sum(!is.na(match(x, opinion.lexicon.neg)))})

scores <-unlist(lapply(corpus4, function(x) { sum(!is.na(match(x, opinion.lexicon.pos))) - sum(!is.na(match(x, opinion.lexicon.neg)))}))
hist(scores)

corpus5 <-as.matrix(corpus4)

corpus3
summary(corpus2)
View(corpus2)
class(corpus4)
