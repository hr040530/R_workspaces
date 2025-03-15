# 데이터프레임

# 첫번 째! 경로 확인
print(list.files()) # 해당경로에 있는 파일 목록
print(getwd()) # 해당경로 조회

# 경로 수정
setwd('D:/r-data')
# setting working directory

# 세번째 파일 불러오기
emp=read.csv('emp.csv') # 파일 불러오기
#View(emp)

### 암기(시험단골)
print(dim(emp)) # 행/열의 수 확인
print(head(emp,4))
print(tail(emp,4))
print(str(emp)) # 데이터프레임 '데이터 타입 확인'

### 특정 열 출력
print(emp$ENAME) # ENAME만 출력

### dplyr(data frame plier) -> 데이터프레임을 다루는 '공구'
#install.packages("dplyr") # 처음에만 설치가 필요함
library(dplyr) # 설치한 dplyr 로드하다.

emp_ename=emp%>%select(ENAME)
print(emp_ename)

# 필터링 후 select
# & : AND 연산자(두 조건이 만족해야함)
emp_data=emp%>%filter(SAL>=2000&DEPTNO==20)%>%select(ENAME,DEPTNO)
print(emp_data)

# filter : 행 필터링
# select : 특정 벡터 선택
# mutate : 새로운 벡터 추가
# arrange : 정령(오름차순, 내림차순)
# summarize + group_by : 데이터 그룹 + 데이터 요약
# R은 group_by 단독 사용 불가능
# join : 여러 데이터프레임 병합

# +slice : 지정된 행 번호에 해당하는 행 선택(head,tail)

library(dplyr)
emp=read.csv('netflix.csv') # 데이터셋 읽기
#문제 3: 데이터셋에서 title, type, release_year 열만 선택하세요.
result=netflix %>% select('title', 'type', 'release_year')
print(result)