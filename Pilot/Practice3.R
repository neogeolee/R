library(readxl)
library(dplyr)
library(stringr)
library(corrplot)

# 데이터 불러오기
stat <- read_xlsx(path = '../file/kbo_2020_batter.xlsx')
head(stat)

# 데이터 전처리
stat$선수명 <- str_remove(string = stat$선수명, pattern = '\\*$')
stat$선수명 <- str_remove(string = stat$선수명, pattern = '\\(타\\)')
stat$선수명 <- as.factor(x = stat$선수명)

print(x = stat$선수명)

# 키움히어로즈 팀명 전처리
stat$팀명 <- str_replace(string = stat$팀명,
                       pattern = 'Hero',
                       replacement = '키움')
stat$팀명 <- as.factor(x = stat$팀명)

table(x = stat$팀명)

# 히스토그램 생성

range(x = stat$타석)

breaks <- seq(from = 0, to = 650, by = 50)
cuts <- cut(x = stat$타석, breaks=breaks, include.lowest = TRUE)

hist(x = stat$타석,
     freq = TRUE,
     breaks = breaks,
     col = 'gray30',
     main = '타석 히스토그램',
     xlab = '타석',
     ylab = '빈도수',
     family = 'AppleGothic')

stat330 <- stat %>% filter(타석 > 330)
breaks <- seq(from = 330, to = 550, by = 30)

hist(x = stat330$타석,
     freq = TRUE,
     breaks = breaks,
     col = 'gray30',
     main = '타석 히스토그램',
     xlab = '타석',
     ylab = '빈도수',
     family = 'AppleGothic')

# OPS 히스토그램 생성

breaks <- seq(from = 0.6, to = 1.1, by = 0.1)
range(x = stat330$OPS)
hist(x = stat330$OPS, breaks = breaks,
     ylim = c(0, 65),
     col = 'pink', labels = TRUE)

stat330 %>% 
  select(선수명, 팀명, OPS) %>% 
  filter(OPS >= 0.9) %>% 
  arrange(desc(OPS))

stat330 %>% 
  select(선수명, 팀명, 홈런, 출루율, 장타율, OPS) %>% 
  filter(OPS >= 0.9) %>% 
  arrange(desc(홈런), desc(OPS))

plot(x = stat330$출루율, y = stat330$장타율, pch = 19, col = 'blue',
     main = '출루율 vs 장타율')
    

ops90 <- stat330 %>% filter(OPS >= 0.9)

plot(x = stat330$출루율, y = stat330$장타율, pch = 19, col = 'blue',
     main = '출루율 vs 장타율')

points(x = ops90$출루율, y = ops90$장타율, pch = 4, col = 'red')

text(x = ops90$출루율, y = ops90$장타율, labels = ops90$선수명,
     pos = 2, col = 'gray50',
     cex = 0.8)
