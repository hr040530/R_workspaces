#문제 1: dplyr 패키지를 로드해주세요.
library(dplyr)
#문제 2: netflix.csv 파일을 불러오세요.
netflix=read.csv('netflix.csv')
#View(netflix)

# 데이터프레임 출력하기
#문제 1: 데이터프레임의 앞부분 출력 단, 2행만
print(head(netflix,2))
#문제 2: 데이터프레임의 뒷부분 출력 단, 5행만
print(tail(netflix,5))
#문제 3: 데이터프레임의 구조 확인 -> 구조확인은 str()로만 확인하는게 정답
print(str(netflix))
#문제 4: 특정 열 title 선택하기
# print(netflix$title)


# Select
#문제 3: 데이터셋에서 title, type, release_year 열만 선택하세요.
result=netflix %>% select(title, type, release_year)
# print(result)
#문제 4: 데이터셋에서 title, country, country 열만 선택하세요.
result= netflix %>% select(title, country, country)
# print(result)

# Filter
#문제 5: 2021년에 출시된 영화만 필터링하세요.
result =netflix %>% filter(release_year == 2021)
# print(result)
#문제 6: TV-MA 등급의 TV 프로그램만 필터링하세요.
result=netflix%>%filter(rating=="TV-MA")
# print(result)

# Select& Filter
#문제 7: director가 "Mike Flanagan"인 영화의 title, director, country 열을 선택하세요.
result=netflix%>%filter(director=="Mike Flanagan",na.rm=TRUE)%>%select(title,director,country)
# print(result)
# Mutate
#문제 8: duration 열에서 영화의 길이가 분 단위로 제공됩니다.
#영화(type == "Movie")의 경우, duration 값을 숫자형 데이터로 변환하고 새로운 열 duration_minutes를 추가하세요.
result=netflix%>%filter(type == "Movie")%>%mutate(duration_minutes=as.numeric(gsub(" min","",duration)))
# print(result)

# Arrange
#문제 9: 영화(type =="Movie")를 기준으로, release_year(출시연도)를 내림차순으로 정렬하세요
result=netflix%>%filter(type =="Movie")%>%arrange(desc(release_year))
#문제 10: TV 프로그램(type == "TV Show") 중 시즌 수(duration)를 기준으로 오름차순으로 정렬하세요.
result=netflix%>%filter(type == "TV Show")%>%
  mutate(seasons=as.numeric(gsub(" Season[s]?","",duration)))%>%arrange(duration)

# Group_by & Summarise
#문제 11: type 열을 기준으로 데이터를 그룹화하고, 각 그룹에 대해 콘텐츠의 총 개수와 평균 release_year를 계산하세요.
#결과 데이터프레임은 type, total_count, average_release_year 열을 포함해야 합니다.
result=netflix%>%group_by(type)%>%summarize(total_count=n(),average_release_year=mean(release_year,na.rm=TRUE))%>%
  select(type,total_count,average_release_year)
 print(result)