health=read.csv('health.csv',fileEncoding = "CP949")
#View(health)

library(dplyr)

#데이터프레임 출력하기
#문제 1: 데이터프레임의 앞부분 출력 단, 2행만
print(head(health,2))
#문제 2: 데이터프레임의 뒷부분 출력 단, 5행만
print(tail(health,5))
#문제 3: 데이터프레임의 구조 확인
print(dim(health))

#Select
#문제 1: 데이터셋에서 성별, 연령대, 그리고 지역 열만 선택하세요.
result1=health%>%select(성별,연령대코드.5세단위.,시도코드)
#View(result1)

#Filter
#문제 2: 2022년에 건강검진을 받은 사람들만 필터링하세요.
result2=health%>%filter(기준년도=='2022')
#View(result2)

#Mutate
#문제 3: 키(height)와 몸무게(weight) 열을 사용하여 새로운 열 BMI를 추가하세요.
health_BMI=health%>%mutate(BMI=체중.5kg단위./(신장.5cm단위./100)^2)
#View(health_BMI)

#Arrange
#문제 4: 건강검진 결과를 기준으로 혈압 값을 내림차순으로 정렬하세요.
result4=health%>%arrange(desc(수축기혈압))
#View(result4)
#Group_by& Summarise
#문제 5: 성별(성별)로 데이터를 그룹화하고, 각 그룹별 평균 BMI를 계산하세요.
#결과는 성별과 평균_BMI 열로 구성되어야 합니다.
result=health_BMI%>%group_by(성별)%>%summarize(평균_BMI=mean(BMI,na.rm=TRUE))
#View(result)

# 문제: 연령대별 평균 체중 계산
result=health%>%group_by(연령대코드.5세단위.)%>%summarize(평균_체중=mean(체중.5kg단위.,na.rm=TRUE))
#print(result)

# 
result=health%>%group_by(시도코드)%>%summarize(평균_신장=mean(신장.5cm단위.,na.rm=TRUE))%>%
  arrange(desc(평균_신장))%>%slice_head(n=1)
#print(result)

# 음주여부에 따라 체중과 허리둘레의 상관관계 알기
# cor(): 상관관계
#use="complete.obs: 상관관계를 계산할 때 결측값이 포함된 데이터는 제외하고 계산한다.
drinking=health%>%group_by(음주여부)%>%summarize(상관계수=cor(체중.5kg단위.,허리둘레,use="complete.obs"))
#View(drinking)

# 1은 true-> 술O
# 0은 false-> 술X
# 상관계수는 보통 -1에서 1까지의 값을 가진다.
# 1: 완벽한 선형관계를 가짐, 즉 한 변수가 증가하면 다른 변수도 증가함
# -1: 한 변수가 증가할 때 다른 변수는 감소함
# 0: 관계없음

# 퀴즈) 연령대 코드가 10이하, 행 개수 추출
result=health%>%filter(연령대코드.5세단위.<=10)%>%nrow()
print(result)
