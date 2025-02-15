### 데이터프레임****************
# R기초단계에서 가장 중요한게 데이터프레임, 벡터

# R프로그래밍에서 ******데이터프레임은 데이터는 '행'과 '열'로 구성된 2차원 구조
# 다양한 데이터 유형을 한 테이블에 저장할 수 있는 자료구조
# 데이터프레임으로 통계분석, 데이터 처리, 그리프 시각화

# 데이터프레임 구조
# 구조 : 행과 열
# 행 : 관측치
# 열 : 속성

ID=c(1,2,3)
Name=c('Alice','Bob','Charlie')
Age=c(25,30,35)
Salary=c(50000,60000,70000)
# 데이터프레임 생성
# data.frame() 암기
df=data.frame(ID,Name,Age,Salary)
print(df) # 데이터 출력

## 데이터프레임 조회하는 다른방법들(***)
## head 암기
print(head(df,1)) # 위에서부터 1행만 출력하겠다
print(head(df,2))
print(head(df)) # 뒤에 숫자가 없으면, 기본값 1~6행까지 출력

# 행과 열의 개수를 알고싶어
# dim() 
print(dim(df))
# 전체 컬럼조회
print(colnames(df))

# 마지막 1행 출력
# tail : 꼬리
print(tail(df,1)) # 아래에서부터 1행 출력
# View(df) # 다른화면으로 출력

### 특정 열만 선택하기
# $기호를 사용하면 결과는 벡터 형태로 반환된다
names=df$Name # 데이터프레임에 'Name'열 가져오기
cat('특정 열 추출 :',names,'\n')
#Age만 추출
age=df$Age # 특정 열 접근은 $
cat('특정 열 추출 :',age,'\n')

## 다수 열 선택
# 이름하고 나이만 출력
result=df[,c('Name','Age')]
print(result)
# ID하고 Salary만 출력
result=df[,c('ID','Salary')]
print(result)

# 특정 열값 수정, 추가
df$Salary=df$Salary + 100
print(df)

df$Age = df$Age + 1 
print(df)

# 데이터프레임에 새로운 열 추가
df$penalty = c('예','아니오','예')
View(df)
