library(ggplot2)
library(dplyr)
library(sf)
library(ggiraph)

korea_map=st_read('sig.shp')
#View(korea_map)

seoul_map=korea_map%>%
  filter(substr(SIG_CD,1,2)=='11')
#View(seoul_map)

dust_data=read.csv('data.csv',fileEncoding = 'CP949',encoding = 'UTF-8',check.names = FALSE)

#View(dust_data)
# 미세먼지 station_code(지역코드)
# 퀴즈, join을 이용해서 shp파일과 data.csv 병합하기
dust_data=dust_data%>%mutate(station_code=as.character(station_code))

# 데이터 타입이 동일해야 병합 가능
merged_data=inner_join(seoul_map,dust_data,by=c("SIG_CD"="station_code"))
#View(merged_data)

p=ggplot(data=merged_data)+
  geom_sf(aes(fill=pm10_concentration_ug_m3),color="black")+
  scale_fill_gradient(low="blue",high="red",name="농도")+
  theme_minimal()+
  labs(title="서울시 미세먼지 농도",x="경도",y="위도")
print(p)

# 1. 24년도 총 직장 인구수가 가장 많은 자치구 5개만 지도로 표현(숙제)
# 2. 서울 총 직장인 인구 수 대비 각 자치구 직장인 인구 수 비율 구하기(숙제)

seoul_work_data=read.csv('서울시 상권분석서비스(직장인구-자치구).csv',
                         fileEncoding = 'CP949',encoding = 'UTF-8',check.names = FALSE)
View(seoul_work_data)

seoul_work_data=seoul_work_data%>%mutate(자치구_코드=as.character((자치구_코드))
merged_data=inner_join(seoul_map,seoul_work_data,by=c("SIG_CD"="자치구_코드"))
View(merged_data)

seoul1=seoul_work_data%>%mutate(year=substr(기준_년분기_코드,1,4))%>%
  filter(year==2024)
