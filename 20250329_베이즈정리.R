# 베이즈 정리
# 조건부 확률을 계산하는 수학적 공식으로, 특정 사건의 발생 확률을
# 증거를 반영하여 계산하다.
# 이 정리는 18세기 영국 수학자 '토마스 베이즈'의 이름을 따서 명명됨

# 실생활 예시
# 금융 : 대출 위험 평가, 투자 성공 확률
# 의료 : 질병의 정확한 진단 확률 계산

# 제조업에서 두개의 생산라인을 가진 공장에서 2000대의 자전거를
# 창고에 적재하였습니다.(각 라인별 1000대씩 생산했다고 가정)
# 조사 하니깐 1번 라인의 경우 8%가 불량
# 2번 라인은 15.7%가 불량임을 알아냈다.
# 창고에 적재한 자전거 하나를 선택하여 조사한 결과
# 이 자전거가 1번 라인의 경우 8%가 불량
# 2번 라인은 15.7%가 불량임을 알아냈다.
# 창고에 적재한 자전거


bike_data=read.csv('bike_data.csv')
#View(bike_data)

# 생산된 자전거 총 수
# nrow: 행 수
bike_total=bike_data%>%nrow()
#print(bike_total)

# 생산 라인 별 자전거 수
bike_count=bike_data%>%group_by(production_line)%>%
  summarise(count=n())
#View(bike_count)

# 생산 라인 별 결함 비율
# defect 1이면 결함을 0이면 정상을 의미
bike_defect=bike_data%>%group_by(production_line)%>%
  summarise(percentage=mean(defect==1)*100)
#View(bike_defect)

# 각 라인별 생산 된 자전거 수와 결함수 변수로 만들기
bike_1_count=bike_count%>%filter(production_line==1)

bike_2_count=bike_count%>%filter(production_line==2)

bike_1_defect=bike_defect%>%filter(production_line==1)

bike_2_defect=bike_defect%>%filter(production_line==2)

# 확률 초기화
p_L1=bike_1_count/bike_total
p_L2=bike_2_count/bike_total

p_D_L1=bike_1_defect$percentage
p_D_L2=bike_2_defect$percentage

# 전체 불량 확률 계싼
p_D=(p_D_L1*p_L1)+(p_D_L2*p_L2)

# 베이즈 정리 적용
bayes=(p_D_L1*p_L1)/p_D
print(bayes*100)

# 베이즈 정리 공식
# P(A|B)=(P(B|A)'P(A)/P(B)
# P(A|B): 사후확률, 사건 B가 발생했을 때 사건 A가 발생할 확률
# P(B|A): 사건 A가 발생했을 때 사건 B가 발생할 확률
# P(A): 사건 A의 사전 확률
# P(B): 사건 B의 사전 확률