setwd('D:/r-data') # 작업 디렉토리 변경
print(list.files()) # R 경로확인

# 데이터프레임(행과 열(벡터))

df=data.frame(
  ID=c(1,2,3),
  NAME=c('brian','Bob','Jose')
)
# 출력
#View(df)
print(df$NAME)

df$ID2=df$ID+1 #특정 열을 가져와서 값을 더한 후 새로운 열에 추가함
print(df$ID2)

# 결측치(Missing Value) 'NA'로 표기
# 예제 데이터 생성
data=c(1,2,NA,4,NA,6)

# 결측치 확인
print(is.na(data)) # is -> ?, is.na => na가 있니?
# na가 있으면 true, 없으면 false

print(!is.na(data)) # !(부정) 반대

## csv(콤마로 구성된 파일)파일 가져오기
emp=read.csv("emp.csv") # emp.cvs 파일 불러오기
#View(emp)
emp_clean=na.omit(emp) # omit: 제거하다
#View(emp_clean)

emp_comm=sum(emp$COMM,na.rm=TRUE) # rm: 제거하다
print(emp_comm)

### 문제풀이
### 데이터 전처리 -> 80~90%
### dplyr
#install.packages('dplyr')
library(dplyr) 
emp=read.csv("emp.csv")

# 문제1
selected_emp=emp%>%select(ENAME,JOB,DEPTNO)
print(selected_emp)

num=c(10,10,NA,5,NA)
result=ifelse(is.na(num),1,num)
print(result)






