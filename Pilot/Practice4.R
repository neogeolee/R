library(KoNLP)
library(dplyr)

useNIADic()

result2.text <- read.csv('../file/compose.csv' , encoding = "UTF-8")
head(result2.text)

result2.text <- gsub("\n", "", result2.text)
result2.text <- gsub("\r", "", result2.text)
result2.text <- gsub("맞팔", "", result2.text)
result2.text <- gsub("선팔", "", result2.text)
result2.text <- gsub("\t", "", result2.text)
result2.text <- gsub("\\", "", result2.text)
result2.text <- gsub("팔로우", "", result2.text)
result2.text <- gsub("맛집", "", result2.text)
result2.text <- gsub("옥정", "", result2.text)
result2.text <- gsub("커피", "", result2.text)
result2.text <- gsub("카페", "", result2.text)
result2.text <- gsub("일상", "", result2.text)
result2.text <- gsub("그램", "", result2.text)
result2.text <- gsub("소통", "", result2.text)
result2.text <- gsub("스타", "", result2.text)
result2.text <- gsub("컴포즈커피", "", result2.text)
result2.text <- gsub("컴포즈", "", result2.text)
result2.text <- gsub("맛그램", "", result2.text)
result2.text <- gsub("[^\uAC00-\uD7A3xfe a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\\s]", "", result2.text)
result2.text <- str_replace_all(result2.text,"[A-Za-z0-9]","")
result2.text <- gsub("[~!@#$%&*()_+=?<>]", "", result2.text)

txt2 <- result2.text
nouns2 <- extractNoun(txt2)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount2 <- table(unlist(nouns2))
# 데이터 프레임으로 변환
df_word2 <- as.data.frame(wordcount2, stringsAsFactors = F)
# 변수명 수정
df_word2 <- rename(df_word2,
                   word = Var1,
                   freq = Freq)
# 두 글자 이상 단어 추출

df_word2 <- filter(df_word2, nchar(word) >= 2)

top2_100 <- df_word2 %>%
  arrange(desc(freq)) %>%
  head(100)

top2_100


#그래프 출력
library(ggplot2)

ggplot(data = top2_100) + geom_bar(aes(x=top2_100$word)) 


# 워드 클라우드 만들기

library(wordcloud)
library(RColorBrewer)

library(wordcloud2)

pal <- brewer.pal(20, 'Dark2')
set.seed(1)

wordcloud(words = df_word2$word,
          freq = df_word2$freq,
          scale = c(10, 1),
          random.order = FALSE,
          random.color = FALSE,
          colors = pal)

wordcloud(words = top2_100$word,
          freq = top2_100$freq,
          scale = c(10, 1),
          random.order = FALSE,
          random.color = FALSE,
          colors = pal)

#워드 클라우드2 이용
wordcloud2(data = df_word2)
wordcloud2(data = top2_100)
