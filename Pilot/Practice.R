install.packages(c("twitteR","ROAuth", "base64enc"))
library(twitteR)
library(ROAuth)
library(base64enc)

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/accsess_token"
authURL <- "https://api.twitter.com/oauth/authorize"

consumerKey <- "C2SI1GDJFYGNj2eQpiEm2dmbx"
consumerSecret <- "49LkoYvWVPz9DIkPIGzgy8PWRFrmrRbhSe4D20pTLVo279av2q"
accesstoken <- "1191670025326755840-vQhnhCmefa3D91TTWhHhOMqXZMWtss"
accesstokensecret <- "URXQ2nvtzAlRgQgLS7uNedK61kdPa01f2uaL3e1T7asfO"

setup_twitter_oauth(consumerKey,consumerSecret,accesstoken,accesstokensecret)

keyword <- enc2utf8("컴포즈커피")

com <- searchTwitter(keyword, since = '2020-09-17', until = '2020-09-24' , n=1500, lang="ko")
length(com)
head(com)

library(KoNLP)
library(dplyr)

useNIADic()

txt2 <- com
head(txt2)

## 트윗 결과 중에서 텍스트에 해당하는 부분만 추출 ***트윗 명사 추출시 포인트!
result2.df <- twListToDF(txt2)
head(result2.df)
result2.text <- result2.df$text
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
result2.text <- gsub("RT", "", result2.text)
result2.text <- gsub("https", "", result2.text)
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

library(wordcloud)
library(RColorBrewer)

install.packages("wordcloud2")
library(wordcloud2)
# 워드 클라우드 만들기

#워드 클라우드2 이용
wordcloud2(data = df_word2)
wordcloud2(data = top2_100)
