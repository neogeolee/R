library(KoNLP)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(stringr)
library(multilinguer)

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

#형태소 분석을 위한 사전 설정
useNIADic()

#텍스트 파일 데이터 생성
brand <- read.csv('../file/compose.csv' , encoding = "UTF-8")
View(brand)

#특수문자 제거
data_brand <- str_replace_all(brand, '\\W', ' ')
View(data_brand)

#명사추출
data_brand_noun <- extractNoun(data_brand)
View(data_brand_noun)

#명사 단어 집계
word_count <- table(unlist(data_brand_noun))
View(word_count)



#데이터프레임으로 변환
df_word <- as.data.frame(word_count, stringsAsFactors = F)
View(df_word)

# 두 문자 이상 단어만 추출
df_word <- df_word %>% filter(nchar(Var1) >= 2) %>% filter(!is.na(Var1))
View(df_word)

top_100 <- df_word %>%
  arrange(desc(freq)) %>%
  head(100)

top_100


#워드클라우드 출력
pal <- brewer.pal(8, 'Dark2')
set.seed(1)

wordcloud(words = df_word$Var1,
          freq = df_word$Freq,
          min.freq = 3,
          random.order = F,
          rot.per = 0.7,
          scale = c(4, 0.3),
          colors = pal)
