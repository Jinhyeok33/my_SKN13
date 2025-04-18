'''
1284번 집 주소
https://www.acmicpc.net/problem/1284

재석이는 대문에 붙이는 (주소를 나타내는) 호수판 제작업체의 직원이다.
고객에게 전달할 호수판은 숫자와 숫자 사이 그리고 왼쪽 오른쪽으로 적당히 여백이 들어가 줘야하고 숫자마다 차지하는 간격이 조금씩 상이하다. 다행이도 규칙은 매우 간단하다. 

1. 각 숫자 사이에는 1cm의 여백이 들어가야한다.
2. 1은 2cm의 너비를 차지해야한다. 0은 4cm의 너비를 차지해야한다. 나머지 숫자는 모두 3cm의 너비를 차지한다.
3. 호수판의 경계와 숫자 사이에는 1cm의 여백이 들어가야한다.

예를 들어 위의 120 같은 경우,  각 숫자 사이에 여백이 1cm 씩 2개 들어간다. 1은 2cm, 2는 3cm, 0은 4cm를 차지한다.
오른쪽, 왼쪽 경계에서 각각 여백이 1cm씩 차지한다. 따라서 총 2 + 2 + 3 + 4 + 1 + 1 = 13(cm) 가 된다.
재석이는 고객에게 전달해야할 호수판의 너비가 얼마나 되는지 궁금해졌다. 재석이를 도와주자!
'''

address_list = [] # 주소를 저장할 리스트
while True:
    address = input() # 주소를 입력받음
    if address == '0':
        break
    address_list.append(address) # 주소를 리스트에 저장
    

for address in address_list:
    blank_length = len(address) + 1 # 각 숫자 사이에 여백이 1cm 씩 들어감
    letter_length = len(address) * 3 # 각 숫자마다 차지하는 길이

    if '1' in address:
        letter_length -= address.count('1')  # 1은 2cm의 너비를 차지함
    if '0' in address:
        letter_length += address.count('0')  # 0은 4cm의 너비를 차지함

    print(blank_length + letter_length) # 주소의 길이와 각 숫자에 해당하는 길이를 더한 값을 출력
