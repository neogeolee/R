#날짜 : 2020/08/05
#이름 : 이태훈
#내용 : 데이터시각화 - 지도 그래프 교재 p290

install.packages('devtools')
install.packages("bindrcpp")
devtools::install_github("dkahle/ggmap")
library('ggmap')
register_google(key = 'AIzaSyBrkMiFk4KP89zVAkrefQdzTiiGAucTcAY')

gc <- geocode('seoul')
gc

seoul <- as.numeric(gc)

#지도출력
map <- get_googlemap(center = seoul,
                     language = 'ko-KR',
                     color = 'bw',
                     zoom = 15)

ggmap(map, extent = 'device')
