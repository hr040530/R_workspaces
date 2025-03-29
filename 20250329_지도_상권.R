library(ggplot2)
library(dplyr)
#install.packages("ggiraph")
library(sf)
library(ggiraph)

# 1. 지도 시각화를 구현하기 위해서는 '지도 데이터'(ShapeFile(shp))가 필요하다
# shp파일은 지리정보시스템에서 사용되는 벡터 데이터 형식으로 공간 데이터를 저장하고 표현하는데 사용

korea_map=st_read('sig.shp')
# View(korea_map)

# 2. 지도 시각화
p=ggplot(data=korea_map)+
  geom_sf(fill="white",color="black")+
  theme_minimal()+
  labs(title="대한민국 지도",
       x="경도",
       y="위도")+
  coord_sf()
print(p)

# 서울만 가져오기
seoul_map=korea_map%>%
  filter(substr(SIG_CD,1,2)=='11')

p=ggplot(data=seoul_map)+
  geom_sf(fill="white",color="black")+
  theme_minimal()+
  labs(title="서울특별시 행정구역",
       x="경도",
       y="위도")+
  coord_sf()
print(p)

seoul_comm_data = read.csv('seoul_commercial_analysis.csv',
                           fileEncoding = 'CP949',
                           encoding = 'UTF-8',
                           check.names = FALSE)
# 퀴즈
# seoul_commercial_analysis.csv 확인 후
# 컬럼 `자치구_코드` 생성 후 기존 `자치구_코드`를 
# 문자로 형변환 해서 대입하기.

# 형변환? 자치구 코드가 뭐길래? 왜 문자로 변환?
# 1. 데이터프레임의 구조를 확인하자
# print(str(seoul_comm_data)) # 구조 확인 ***str

# 형변환
seoul_comm_data = seoul_comm_data %>%
  mutate(자치구_코드 = as.character(자치구_코드))

# 자치구 코드를 문자로 바꾼 이유?
# shp(지도)파일에 지치구 코드가 있는데
# 지도파일에 자치구 코드가 문자형이여서

# 왜? 병함하기 위해서 지도데이터와 상권데이터 병합하기

# seoul_map에 있는 SIG_CD와 seoul_comm_data에 있는 자치구_코드를 '기준'으로 두 파일 병합하기
merged_data=inner_join(seoul_map,seoul_comm_data,
                       by=c("SIG_CD"="자치구_코드"))
View(merged_data)

# 퀴즈, SIG_CD,자치구코드명,geometry(위도,경도)를 그룹핑해서
# '젅체 폐업 영업 개월 평균'의 평균 구하기
# 폐업영업평균이 60이하면 High, 아니면 Normal을 나타내는 위험도 컬럼을 추가할 것
merged_data=merged_data%>%group_by(SIG_CD,자치구_코드_명,geometry)%>%
  summarize(영업평균=mean(폐업_영업_개월_평균))%>%
  mutate(위험도=ifelse(영업평균<=60,'High','Normal'))

# 사분위수를 이용해서 특정 구간 알고 싶을 때
# quantile: 사분위수
quantiles=quantile(merged_data$영업평균)
merged_data=merged_data%>%filter(영업평균>=quantiles["75%"])

#View(merged_data)

# 지도 시각화
p=ggplot(data=merged_data)+
  scale_fill_gradient(low="#ececec",
                      high="blue",
                      name="영업평균")+ # 지도 색깔 설정
  geom_sf_interactive(
    aes(
      fill = 영업평균, # 영업 평균 데이터를 지도에 채우기
      tooltip = 자치구_코드_명,
      data_id = SIG_CD
    )
  ) + # 마우스 호버 이벤트
  theme_minimal()+
  labs(title="서울시 폐업 평균 개월",
       x="경도",
       y="위도")

print(p)
girafe_plot = girafe(ggobj = p) #인터랙티브 지도 생성

print(girafe_plot) #지도 출력

