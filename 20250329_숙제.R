library(ggplot2)
library(dplyr)
library(sf)
library(ggiraph)

korea_map=st_read('sig.shp')
#View(korea_map)

seoul_map=korea_map%>%
  filter(substr(SIG_CD,1,2)=='11')
#View(seoul_map)

seoul_work_data=read.csv('서울시 상권분석서비스(직장인구-자치구).csv',
                         fileEncoding = 'CP949',encoding = 'UTF-8',check.names = FALSE)
#View(seoul_work_data)
# 1. 24년도 총 직장 인구수가 가장 많은 자치구 5개만 지도로 표현(숙제)
# 2. 서울 총 직장인 인구 수 대비 각 자치구 직장인 인구 수 비율 구하기(숙제)

#가중평균=∑(값×가중치)
#직장인인구율 = 24년도_직장인인구율 + 24년도_직장인증가율
#폐점율 = 24년도_폐점율 + 24년도_폐점증가율
#직장인_가중치  = 0.6 (직장인 수, 소비 패턴, 직장인 월급)
#폐점_가중치 = 0.4 (임대료 상승, 경기 침체)
#폐점_확률 = (직장인인구율 * 직장인_가중치) + (폐점율 * 폐점_가중치)

seoul_work_data=seoul_work_data%>%mutate(자치구_코드=as.character(자치구_코드))
merged_data=inner_join(seoul_map,seoul_work_data,by=c("SIG_CD"="자치구_코드"))
#View(merged_data)

seoul=merged_data%>%
  mutate(year=substr(기준_년분기_코드,1,4))%>%
  filter(year==2024)
#View(seoul)

seoul_top=seoul%>%group_by(자치구_코드_명)%>%
  summarize(총직장인구수=sum(총_직장_인구_수))%>%
  arrange(desc(총직장인구수))%>%
  slice(총직장인구수,1:5)
View(seoul_top)

p=ggplot(data=seoul_top5)+
  geom_sf(aes(fill=총직장인구수),color="black")+
  scale_fill_gradient(low="blue",high="red",name="직장인구수")+
  theme_minimal()+
  labs(title="24년도 총직장인구수 순위",x="경도",y="위도")
print(p)