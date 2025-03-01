# 대문자와 소문자를 구별해요
# 사람끼리 정보를 주고받을 때는 숫자와 문자로 충분
# 그런데 컴퓨터는 논리형(bool)이 필요합니다.
# 3.논리형은 true, false
# 4.범주형 => 예) 혈액형, 성별, 고객만족도
# 범주형 특징 => 그룹화 하기 위해서, 계산적 의미는 없다
# 5.***** 결측값 => 관측/측정에 실패한 값

x=10
print(x)

### 데이터프레임 : 행과 열로 구성된 2차원 구조
df=data.frame(
  ID=c(1,2,3), # c는 벡터
  NAME=c('김길동','박길동','홍길동')
)
# View(df)

# ***데이터프레임 조회
print(head(df,2))
print(dim(df))
print(tail(df,2))
print(str(df)) # 각각 열의 데이터 타입을 확인할 수 있음

# 특정 열 선택
name=df$NAME
print(name)

# 다중 열 선택
emp=df[,c('ID','NAME')] # id,name 컬럼(열)만 조회
print(emp)

# 새로운 열 추가
df$JOB=c('MANAGER','MANAGER','SALES')
# View(df)
# 퀴즈=> 새로운 열 급여(SAL) 추가하기
df$SAL=c(3000,3200,1500)
print(df)

# 특정 열 값 수정하기
df$SAL=df$SAL*2
print(df)

# 데이터프라임->CSV(엑셀)파일로 저장
write.csv(df,file='sample_dataframe.csv')
# 기본 경로는 '문서'에 저장됩니다. 근데 왜인지 모르지만 r_workspaces에 저장되네?



