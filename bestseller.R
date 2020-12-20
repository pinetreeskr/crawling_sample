
install.packages("httr")  # httr설치 - 설치만하고 변수지정하면 안됌, library통해서 불러오기까지해야한다.
library("httr") # httr불러오기

#GET 함수로 서버에 정보 요청하기
url="http://www.kyobobook.co.kr/bestSellerNew/bestseller.laf?orderClick=d79"# 주소를 따옴표해서 url변수에 저장하기
data=GET(url) # GET함수로 url 불러오는 행위를 data라는 변수에 저장하기. -> 콘솔에 data 입력후 결과 확인 -> status:200은 서버에 내용을 요청한것이 성공했다는 의미. 

#read_html 함수를 이용하여, 받아온 데이터의 html 코드를 읽어오는 것 -> rvest 패키지 필요
install.packages("rvest")
library("rvest")

my_html=read_html(data,encoding='EUC-KR') #(변수, 인코딩방식) - 변수data를 한글로 인코딩해서 read_html함수를 통해서 받아온 html내용을불러옴, 그 결과를my_html 변수에 저장- 콘솔에서 my_html입력하여 확인가능 .

#원하는 책 제목들을 추려내야하는 방식 - html 태그를 이용하기 - 개발자도구를 통해서 마우스가 어디에 위치하는지 확인. 
#<strong>트렌드 코리아 2021</strong> 
#여기서 할수있는생각: 실제 strong 태그로 감싸져있는 텍스트들을 다 불러와보자

pick1=html_nodes(my_html, 'strong')#어떤 특정 태그로 감싸져있는 텍스트를 추려낼 떄 사용하는 함수:html_nodes - my_html에 저장된 html코드 중, strong태그로 감싸진 텍스트만 불러오겠다. - 콘솔에서 확인 가능. 

#불필요한 데이터도 있으니깐, 테그를 좀 더 추가. 
# <strong>트렌드 코리아 2021</strong> 는 <a>로 감싸져있음
pick1=html_nodes(my_html, 'a strong') # a태그를 추가해줌 => 아까보다 불필요한 내용을 조금 사라짐

#제목만 추리기 - title 이라는 클래스로 둘러싸여있음을 확인
pick1=html_nodes(my_html, 'title a strong') # title이라는 태그를 추가한것이므로 목적에 맞지않은 정보가 나옴
pick1=html_nodes(my_html, '.title a strong')# .title -> 클래스라는 의미 - title클래스 안에, a태그 안에, strong태그 안에 있는 택스트를 불러오겠다는 의미

# <strong>태그를 제외시키고 출력하고싶음 : html_text함수 사용
html_text(pick1)#pick1에 있는 내용 중 태그는 제외시키고 출력하겠다는 의미





