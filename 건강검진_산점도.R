#퀴즈
# 건강검진 csv파일을 사용해서 신장과 몸무게 관계를 산점도 그래프로 표현하라
# x축은 신장  y축은 체중, 회귀선 추가
health_data=read.csv('health.csv',fileEncoding='CP949',encoding="UTF-8",
                     check.names=FALSE)
#View(health_data)

library(ggplot2)
library(plotly)

p = ggplot(data = health_data,aes(x=`신장(5cm단위)`,y=`체중(5kg단위)`))+
             geom_point(size = 2)+
             geom_smooth(method='lm',color='#fcc954')+
             labs(title = "신장과 몸무게의 관계",
                  x = "신장(5cm단위)",
                  y = "체중(5kg단위)")
#print(p)

# 혈색소 vs BMI 관계 파악하고 싶다.
# BMI=체중/(신장/100)^2

# 디플리알을 이용해서 전처리 작업을 한다

health_data2=health_data%>%mutate(BMI=`체중(5kg단위)`/(`신장(5cm단위)`/100)^2,
                                  Grade=ifelse(혈색소>=16,"High","Normal"),
                                  Gender=ifelse(성별==1,"Male","Female"))
#View(health_data2)

# 전처리 끝났으면 그래프로 표현하기
p=ggplot(data=health_data2,aes(x=혈색소, y=BMI))+
  geom_point(aes(color=Gender,shape=Grade),size=1.5)+
  scale_color_manual(values=c("Male"="blue","Female"="red"))+
  scale_shape_manual(values=c("High"=17,"Normal"=16))+
  geom_smooth(method=lm,color="orange")+
  labs(title="BMI와 혈색소 관계",
       x="혈색소",
       y="BMI",
       color="Gender",
       shape="Grade")+
  theme_minimal() # 뒤에 회색 배경 지우기
#print(p)

# 퀴즈
# 연령코드가 5~8번이고 지역코드가 41번인 사람의 허리둘레와 식전혈당(공복혈당) 관계를 그래프로 표현
# 단 남성은 파랑생 여성은 빨강색 표시
#식전혈당(공복혈당)100 이상은 별 모양(11번) 그외 동그라미로 표기하기
# pdf 저장까지 할 것
health=health_data2%>%filter(`연령대코드(5세단위)`>=5&`연령대코드(5세단위)`>=8&`시도코드`==41)%>%
  mutate(혈당수치=ifelse(`식전혈당(공복혈당)`>=100,"high","normal"))
#View(health)

p=ggplot(data=health,aes(x=`식전혈당(공복혈당)`,y=`허리둘레`))+
  geom_point(aes(color=Gender,shape=`혈당수치`),size=1.5)+
  scale_color_manual(values=c("Male"="blue","Female"="red"))+
  scale_shape_manual(values=c("high"=11,"normal"=16))+
  geom_smooth(method=lm,color="orange")+
  labs(tilte="허리둘레와 식전혈당 관계",
       x="식전혈당(공복혈당)",
       y="허리둘레",
       color="Gender",
       shape="혈당수치")+
  theme_minimal()
print(p)
pdf.options(family="Korea1deb")
ggsave("허리둘레와 식전혈당 관계.pdf")

# 선생님 버젼
health_data3 = health_data %>% 
  filter((`연령대코드(5세단위)` >= 5 
          & `연령대코드(5세단위)` <= 8)
         & 시도코드 == 41) %>% 
  mutate(Gender = ifelse(성별 == 1, "Male", "Female"),
         Grade = ifelse(`식전혈당(공복혈당)` >= 100, "High","Normal")
  ) %>% 
  select(허리둘레, `식전혈당(공복혈당)`,Gender,Grade)

p = ggplot(data = health_data3, aes(x = `식전혈당(공복혈당)`,y = 허리둘레)) +
  geom_point(aes(color = Gender, shape = Grade), size = 1.5) +
  scale_color_manual(values = c("Male" = "blue", "Female" = "red")) +
  scale_shape_manual(values = c("High" = 11, "Normal" = 16)) +
  geom_smooth(method = "lm", color = "orange") +
  labs(title = "식전혈당(공복혈당) vs 허리둘레"
       , x = "식전혈당(공복혈당)"
       , y = "허리둘레"
       , color = "Gender"
       , shape = "Grade") +
  theme_minimal()

print(p)
