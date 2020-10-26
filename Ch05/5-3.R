#날짜 : 2020/08/04
#이름 : 이태훈
#내용 : 데이터시각화 - 막대그래프 교재 p141

install.packages('ggplot2')
library(ggplot2)

#기본 막대그래프
score <- c(80,72,60,78,82,94)
names(score) <- c('김유신','김춘추','장보고','강감찬','이순신','장약용')
barplot(score)

df_exam <- read.csv('../file/exam.csv')
barplot(df_exam$math)

#ggplot2 막대그래프
qplot(data = df_exam, x=id, y=math, geom = 'col')
