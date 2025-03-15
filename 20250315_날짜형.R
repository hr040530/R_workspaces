Sys.setlocale("LC_TIME","C")

date_str='September 24, 2021'
#R은 해당 문자를 바로 날짜형으로 변환할 수 없다.
date_str=as.Date(date_str,format='%B %d, %Y') # 형식 맞추기
print(date_str)
date_str_1='2025-03-15'
formatted_date=format(date,'%Y')# 년도만 나오게
print(formatted_date)

date_str_1='2025-03-15'
formatted_date=format(date,'%Y') # 문제없이 Date로 형변환
print(formatted_date)

# 퀴즈) 2021년에 추가된 영화의 타이틀 추출

netflix=netflix%>%mutate(formatted_add_date=as.Date(date_added,format='%B %d, %Y'))
View(netflix)
result=netflix%>%filter(type=='Movie'&format(formatted_add_date,'%Y')==2021)%>%select(title)
print(result)