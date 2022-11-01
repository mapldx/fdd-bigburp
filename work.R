# install.packages("RJSONIO")
library(RJSONIO)
# install.packages("tidyr")
library(tidyr)
# install.packages("tidytext")
library(tidytext)
# install.packages("tidyverse")
library(tidyverse)
# install.packages("dplyr")
library(dplyr)
# install.packages("readtext")
library(readtext)
# install.packages("quanteda")
library(quanteda)
# install.packages("textcat")
library(textcat)
# install.packages("stringr")
library(stringr)
# install.packages("qdapDictionaries")
library(qdapDictionaries)

apps <- fromJSON("grants_applications_gr15.json")
apps <- lapply(apps, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})
apps <- as.data.frame(do.call("cbind", apps))
apps <- as.data.frame(t(apps))

# subset into descriptions with relevant information
desc <- subset(apps, select = c(grant_id, approved, title, description))

# separate descriptions into words
desc <- desc %>% 
  unnest_tokens("word", "description") %>%
  anti_join(stop_words, by = c("word" = "word"))

# clean data
desc <- desc[textcat(desc$word) == "english", ]
desc <- na.omit(desc)

is.word  <- function(x) x %in% GradyAugmented
desc <- subset(desc, is.word(desc$word))
desc <- subset(desc, !grepl("[0-9]", word))

url_regex <- '^(http:\\/\\/www\\.|https:\\/\\/www\\.|http:\\/\\/|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?$'
desc$word <- str_remove_all(desc$word, url_regex)

word_freq <- function(x, top = 10) {
  x %>% 
    count(word, sort = TRUE) %>%
    mutate(word = factor(word, levels = rev(unique(word)))) %>% 
    slice_max(word, n = top) %>%
    ungroup() %>%
    ggplot(mapping = aes(x = word, y = n)) +
    geom_col(show.legend = FALSE) +
    coord_flip() +
    labs(x = NULL)
}

desc %>% 
  word_freq(50)

desc_idf <- desc %>%
  count(title, approved, word, sort = TRUE) %>%
  bind_tf_idf(title, word, n)

desc_idf <- desc_idf %>%
  arrange(desc(desc_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>%
  group_by(title) %>%
  top_n(5) %>%
  ungroup()

# get approved applications
incl_idf <- subset(desc_idf, approved == TRUE)

incl_idf %>% 
  word_freq(28)

# least relevant keywords
incl_idf <- arrange(incl_idf, n, tf_idf)

# most unique keywords
incl_idf <- arrange(incl_idf, n, desc(tf_idf))

# most relevant keywords
incl_idf <- arrange(incl_idf, desc(n), desc(tf_idf))

sample <- as.data.frame(incl_idf[1:3,]$title)
colnames(sample) <- "title"

incl_1 <- subset(incl_idf, title == sample$title[1])
ggplot(incl_1, aes(tf_idf, fct_reorder(word, tf_idf), fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free") +
  labs(x = "tf-idf", y = NULL)

incl_2 <- subset(incl_idf, title == sample$title[2])
ggplot(incl_2, aes(tf_idf, fct_reorder(word, tf_idf), fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free") +
  labs(x = "tf-idf", y = NULL)

incl_3 <- subset(incl_idf, title == sample$title[3])
ggplot(incl_3, aes(tf_idf, fct_reorder(word, tf_idf), fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free") +
  labs(x = "tf-idf", y = NULL)

# get declined applications
decl_idf <- subset(desc_idf, approved == FALSE)

decl_idf %>% 
  word_freq(22)

# least relevant keywords
decl_idf <- arrange(decl_idf, n, tf_idf)

# most unique keywords
decl_idf <- arrange(decl_idf, n, desc(tf_idf))

# most relevant keywords
decl_idf <- arrange(decl_idf, desc(n), desc(tf_idf))

sample <- as.data.frame(decl_idf[1:3,]$title)
colnames(sample) <- "title"

decl_1 <- subset(decl_idf, title == sample$title[1])
ggplot(decl_1, aes(tf_idf, fct_reorder(word, tf_idf), fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free") +
  labs(x = "tf-idf", y = NULL)

decl_2 <- subset(decl_idf, title == sample$title[2])
ggplot(decl_2, aes(tf_idf, fct_reorder(word, tf_idf), fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free") +
  labs(x = "tf-idf", y = NULL)

decl_3 <- subset(decl_idf, title == sample$title[3])
ggplot(decl_3, aes(tf_idf, fct_reorder(word, tf_idf), fill = title)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~title, ncol = 2, scales = "free") +
  labs(x = "tf-idf", y = NULL)

write.csv(desc, "descriptions.csv")
write.csv(incl_idf, "approved_projects_idf.csv")
write.csv(decl_idf, "denied_projects_idf.csv")
