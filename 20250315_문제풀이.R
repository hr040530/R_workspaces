library(dplyr)
netflix=read.csv('netflix.csv') # 데이터셋 읽기
#View(emp)
#문제 3: 데이터셋에서 title, type, release_year 열만 선택하세요.
result=netflix %>% select('title', 'type', 'release_year')
print(result)

#퀴즈) 2021년에 제작된 영화의 평균 길이를 구하세요
# filter, mean, summarize, gsub, as.numeric
# 문자 제거 -> gsub(문자제거) -> as.numeric (형변환) 
result=netflix%>%filter(type=='Movie'&release_year==2021)%>%
  summarize(avg_duration=mean(as.numeric(gsub(" min","",duration))))
#View(result)

# 퀴즈) 년도별 제작된 영화의 평균 길이
result=netflix%>%filter(type=='Movie')%>%
  group_by(release_year)%>%summarize(avg_duration=mean(as.numeric(gsub(" min","",duration)),na.rm=TRUE))
#View(result)

# 장르가 Comedies인 '영화' 제목
# listed_in %in% c('Comedies') : listed_in에 Comedies가 포함되었는지 체크해줌.
result=netflix%>%filter(type=='Movie'&listed_in%in%c('Comedies'))%>%
  select(title)
print(result)

#'International TV Shows'장르에 속하고 TV-MA등급인 TV Show의 title과 제작국가를 추출
result=netflix%>%filter(type=='Tv Show'&listed_in%in%c('International TV Shows')&rating=='TV-MA')%>%
  nrow()
#nrow:행 갯수
print(result)

# United States에서 제작된 영화의 개수 추출
result=netflix%>%filter(type=='Movies'&country=='United States')%>%nrow()
print(result)

# 국가별 영화 수
result=netflix%>%filter(type=='Movie'&country !='')%>%group_by(country)%>%summarize(moive_count=n())
#View(result)

# 국가별 영화 수 -> 가장 영화가 많은 국가(상위 5개만 추출)
# 등수 구하는 분석할 때 '정렬'
result=netflix%>%filter(type=='Movie'&country !='')%>%group_by(country)%>%summarize(count=n())%>%
  arrange(desc(count))%>%slice_head(n=5)
#View(result)

#감독별 가장 많이 넷플릭스에 등록한 감독 상위 1명
result=netflix%>%filter(director !='')%>%group_by(director)%>%
  summarize(count=n())%>%arrange(desc(count))%>%slice_head(n=1)
View(result)

# install.packages('tidyr')
library(tidyr) # <- separate_rows(사용가능)
# separate_rows: 디플리알 문법X
#=> listed_in 분리할거야! sep=", "<- 요기준으로 분리 부탁해

#넷플릭스 가장 많이 등장하는 장르 상위 5개
result=netflix%>%separate_rows(listed_in, sep=", ")%>%group_by(listed_in)%>%summarize(count=n())%>%
  arrange(desc(count))%>%slice_head(n=5)
#View(result)
