#날짜 : 2020/08/05
#이름 : 이태훈
#내용 : R MongoDB 연동

install.packages('mongolite')
library(mongolite)
library(dplyr)

conn <- mongolite::mongo(url = 'mongodb://lth:1234@192.168.50.82:27017/lth',
                         db ='lth',
                         collection = 'movies',
                         verbose = TRUE,
                         options = ssl_options())
df_movies <- conn$find()
View(df_movies)