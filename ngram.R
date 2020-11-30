n2words <- readRDS("./2words.rds")
n3words  <- readRDS("./3words.rds")
n4words <- readRDS("./4words.rds")

n2gram <- function(input_words){
        num <- length(input_words)
        filter(n2words, word1 == input_words[num]) %>% top_n(1, n) %>% filter(row_number() == 1L) %>% select(num_range("word", 2)) %>% as.character() -> out
        ifelse(out =="character(0)", "?", return(out))}

n3gram <- function(input_words){
        num <- length(input_words)
        filter(n3words, word1 == input_words[num-1], word2==input_words[num])  %>% top_n(1, n) %>% filter(row_number() == 1L) %>% select(num_range("word", 3)) %>% as.character() -> out
        ifelse(out=="character(0)", bigram(input_words), return(out))}

n4gram <- function(input_words){
        num <- length(input_words)
        filter(n4words, word1 == input_words[num-2], word2==input_words[num-1], word3==input_words[num])  %>% top_n(1, n) %>% filter(row_number() == 1L) %>% select(num_range("word", 4)) %>% as.character() -> out
        ifelse(out=="character(0)", trigram(input_words), return(out))}

ngrams <- function(input){
        input <- data_frame(text = input)
        replace_reg <- "[^[:alpha:][:space:]]*"
        input <- input %>% mutate(text = str_replace_all(text, replace_reg, ""))
        input_count <- str_count(input, boundary("word"))
        input_words <- unlist(str_split(input, boundary("word")))
        input_words <- tolower(input_words)
        out <- ifelse(input_count == 0, "Please input a phrase",
                      ifelse(input_count == 3, n4gram(input_words),
                             ifelse(input_count == 2, n3gram(input_words), n2gram(input_words))))
        return(out)}