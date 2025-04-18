'''
[창고 정리]
문제 설명
선빈이는 게임을 즐기던 중 가지고 있는 물건이 너무 많아 창고 정리를 하기로 했습니다. 선빈이가 보유한 게임 속 창고는 여러 칸으로 나누어져 있고 
각 칸에는 물건들이 담겨있습니다. 창고를 정리할 방법을 고민하던 선빈이는 같은 물건이 여러 칸에 나누어 들어있는 것을 발견하고 우선 같은 물건끼리 
최대한 겹쳐쌓는 방식으로 창고를 정리하기로 했습니다. 선빈이의 창고에 들어있는 물건의 이름과 개수는 리스트 형태로 주어지며, 한 칸에 겹쳐질 수 있는 
물건의 개수에는 제한이 없다고 가정합니다.
예를 들어 창고의 각 칸에 담겨있는 물건의 이름이storage = ["pencil", "pencil", "pencil", "book"], 각 물건의 개수가 num = [2, 4, 3, 1]이라면 
연필과 책을 한 칸에 각각 겹쳐 쌓아 간단하게 clean_storage = ["pencil", "book"], clean_num = [9, 1]로 만들 수 있습니다.
주어진 solution 함수는 정리되기 전 창고의 물건 이름이 담긴 문자열 리스트 storage와 각 물건의 개수가 담긴 정수 리스트 num이 주어질 때, 
정리된 창고에서 개수가 가장 많은 물건의 이름을 return 하는 함수입니다. solution 함수가 올바르게 작동하도록 한 줄을 수정해 주세요.
'''

def solution(storage, num):
    dict_storage = {}

    for key, value in zip(storage, num):
        if key in dict_storage:
            dict_storage[key] += value
        else:
            dict_storage[key] = value

    return max(dict_storage, key=dict_storage.get)


storage = ["pencil", "pencil", "pencil", "book"]
num = [2, 4, 3, 1]	# "pencil"
print(solution(storage, num))

storage = ["doll", "doll", "doll", "doll"]
num = [1, 1, 1, 1]	# "doll"
print(solution(storage, num))

storage = ["apple", "steel", "leaf", "apple", "leaf"]
num = [5, 3, 5, 3, 7]	# "leaf"
print(solution(storage, num))

storage = ["mirror", "net", "mirror", "net", "bottle"]
num = [4, 1, 4, 1, 5]	# "mirror"
print(solution(storage, num))

