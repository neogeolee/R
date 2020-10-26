#날짜 : 2020/08/05
#이름 : 이태훈
#내용 : R데이터베이스 연동

install.packages('RMySQL')
library(RMySQL)
library(dplyr)
library(ggplot2)

conn <- dbConnect(MySQL(),
                     host='192.168.50.82',
                     user='lth',
                     password='1234',
                     dbname='lth')
#데이터프레임 생성
df_sale2017 <- dbGetQuery(conn, statement = 'SELECT * FROM `SALE_2017`')
View(df_sale2017)

df_sale2017 <- df_sale2017 %>% group_by(uid) %>% summarise(total=sum(sale)) %>% arrange(desc(total))
View(df_sale2017)

#그래프 출력
ggplot(data=df_sale2017, aes(x=uid, y=total )) +geom_bar()
