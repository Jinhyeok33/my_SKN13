'''
[닉네임 규칙]
문제 설명
온라인 서비스를 이용하기 위해서 닉네임이 필요합니다. 이때 닉네임이 될 수 있는 조건은 다음과 같습니다.
닉네임의 길이가 4자 이상 8자 이하여야합니다.
닉네임에는 소문자 l과w, 대문자 O와 W를 사용할 수 없습니다.
이외의 영어 대소문자와 숫자는 모두 사용이 가능합니다.
주어진 solution 함수는 사용할 수 없는 닉네임 nickname을 받아 사용할 수 있는 닉네임으로 바꿔주는 함수입니다. 
이때 닉네임을 변경하는 규칙은 다음과 같으며 첫 번째 규칙부터 순서대로 적용합니다.
소문자 l을 대문자 I로 변경합니다.
소문자 w를 두 개의 소문자 v, 즉 vv로 변경합니다.
대문자 W를 두 개의 대문자 V, 즉 VV로 변경합니다.
대문자 O를 숫자 0으로 변경합니다.
수정된 닉네임의 길이가 4 미만일 경우 뒤에 소문자 o를 길이가 4가 될때까지 이어붙입니다.
수정된 닉네임의 길이가 8보다 클 경우 8번째 문자까지만 사용합니다.
주어진 solution 함수에는 위의 규칙 중 올바르게 적용되지 않는 것이 있습니다. solution 함수가 올바르게 작동하도록 한 줄을 수정해주세요.
'''

def solution(nickname):
    result = ""
    for letter in nickname:
        if letter == 'l':
            result += 'I'
        elif letter == 'w':
            result += "vv"
        elif letter == 'W':
            result += "VV"
        elif letter == "O":
            result += '0'
        else:
            result += letter

    if len(result) < 4:
        while len(result) != 4:
            result += 'o'
    if len(result) > 8:
        result = result[:8]

    return result


print(solution("WORLDworld"))
print(solution("GO"))