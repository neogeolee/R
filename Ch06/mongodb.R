#날짜 : 2020/08/05
#이름 : 이태훈
#내용 : Mongodb

install.packages('mongolite')
library(mongolite)
library(KoNLP)
library(dplyr)
library(stringr)
library(wordcloud)
library(RColorBrewer)

conn <- mongolite::mongo(url = 'mongodb://lth:1234@192.168.50.82:27017/lth',
                         db ='lth',
                         collection = 'movies',
                         verbose = TRUE,
                         options = ssl_options())
df_movies <- conn$find()
View(df_movies)

df_movies <- df_movies %>% filter(nchar(reple) >= 2) %>% filter(!is.na(reple))
View(df_movies)

pal <- brewer.pal(8, 'Dark2')
set.seed(1)

wordcloud(words = df_movies$reple,
          freq = df_movies$Freq,
          min.freq = 3,
          random.order = F,
          rot.per = 0.7,
          scale = c(4, 0.3),
          colors = pal)
