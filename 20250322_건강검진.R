library(dplyr)

setwd('D:/r-data')
# 컬럼이 한글일 때 fileEncoding='CP949'
health_data=read.csv('health.csv',fileEncoding='CP949',encoding="UTF-8",
                     check.names=FALSE)
#View(health_data)

#health_data= health_data%>%select(`연령대코드(5세단위)`,`시력(좌)`)
#print(health_data)

# 시력(좌)와 시력(우) 평균이 0.9이하면 vision이라는 컬럼에 Check아니면 No Check를 생성하시오.
result = health_data%>%mutate(vision=ifelse((`시력(좌)`+`시력(우)`)/2<=0.9,'Check','No Check'))
#View(result)

# vision 별 Check와 No Check수 조회
group_result = result%>%group_by(vision)%>%summarize(count=n())
#View(group_result)

#이완기 혈압이 평균보다 낮은 사람 행의 수
#filter에 mean, 
r_mean_result = health_data%>%filter(이완기혈압<mean(이완기혈압))%>%nrow()
#print(r_mean_result)

# min-max 스케일링
# 남성의 혈청지오티(간기능 검사)를 최소-최대(min-max)적도롤 변환후 변환된 값이 큰 남성의 연령대코드,신장, 체중,
# 혈정지오티 추출하기, 단 혈청지오티 기준으로 내림차순

# 혈청지오티 40 U/L 이하는 정상
# 성별 1 : 남자, 2: 여자
scaled_health = result %>% 
  filter(성별== 1) %>% 
  mutate(AST_Scaled= (`혈청지오티(AST)`- min(`혈청지오티(AST)`)) / (max(`혈청지오티(AST)`)-min(`혈청지오티(AST)`)) )

#View(scaled_health)


scaled_health = scaled_health %>%
  filter(AST_Scaled > 0.8) %>%
  select(`연령대코드(5세단위)`, 
         `신장(5cm단위)`, 
         `체중(5kg단위)`, 
         `혈청지오티(AST)`) %>%
  arrange(desc(`혈청지오티(AST)`))

View(scaled_health)

result=health_data%>%
  filter(`연령대코드(5세단위)`>=5 & `연령대코드(5세단위)`<=15)%>%
  group_by(`연령대코드(5세단위)`)%>%
  summarize(
    시력좌평균 = mean(`시력(좌)`, na.rm = TRUE),
    시력우평균 = mean(`시력(우)`, na.rm = TRUE)
  ) %>%
  arrange(desc(시력좌평균),desc(시력우평균))
View(result)
