# R 디렉토리 변경
setwd('D:/r-data')
print(list.files()) # 해당 경로 파일 확인

# CSV(엑셀) 불러오기
data=read.csv('student_data.csv')
#View(data)

# 각 과목(Math, Science, English)의 평균 점수를 계산하세요
math=mean(data$Math)
print(math)
science=mean(data$Science)
print(science)
english=mean(data$English)
print(english)

# 컴퓨터 총합을 구하시오
computer=sum(data$Computer,na.rm=TRUE)
print(computer)

# 영어 표준편차
print(sd(data$English))
# 과학 중앙값
print(median(data$Science))
# 수학 사분위수
print(quantile(data$Math))

# 최댓값, 최솟값
# 수학 과목의 최댓값, 최솟값 구하기
math_max=max(data$Math)
math_min=min(data$Math)
cat('최솟값 :',math_min,'\n')
cat('최댓값 :',math_max,'\n')

# table
print(table(data$English))

# 데이터프레임 기초 통계량 전체 확인
# summary 사용하면 각 컬럼(열)별 기본 통계 확인
print(summary(data))

#install.packages("ggplot2")
library(ggplot2)

graph_data=data.frame(
  x=c('수학평균','영어평균','과학평균'),
  y=c(math,english,science)
)
# 그래프 생성
result=ggplot(data=graph_data,aes(x=x,y=y))+
  geom_col(fill='steelblue')+
  labs(
    title="과목평균",
    x="과목",
    y="평균점수"
  )+
  theme_minimal()
print(result)
