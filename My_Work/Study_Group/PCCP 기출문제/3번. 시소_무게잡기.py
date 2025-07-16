# 시소 무게잡기
# 중앙을 기준으로 양쪽으로 n개만큼의 칸을 가진 시소가 존재한다.
# 시소 위에는 무게추들이 존재하며 이 무게추들은 중심으로부터 떨어진 거리*질량 만큼의 무게를 가진다.
# 무게추들의 질량을 나타낸 1차원 배열이 주어진다.
# ex) [1, 2, 0, 0, 2, 3] 일 때 4개의 추는 순서대로 3kg, 4kg, 4kg, 9kg의 무게를 가지므로 시소는 오른쪽으로 기운다.
# 시소의 무게추를 최소한으로 빼는 배열을 인덱스를 담아 반환하여라.
# 단, 최소한으로 빼는 경우의 수가 여러가지인 경우 왼쪽에서부터 먼저 빠지는 경우를 세기로 한다.
# 아무것도 빼지 않아도 되는 경우 -1을 반환하여라.



















from itertools import combinations
def solution(seesaw):
    n = len(seesaw)//2

    # 추가 있는 index 리스트 만들기 - combination 효율적으로 해야하니까 
    indecis = [i for i, weight in enumerate(seesaw) if weight]
    # indecis = [0, 3, 4, 5]

    # 무게로 변환하기, 왼쪽/오른쪽을 양수/음수로
    answer = [weight*(n-i) if i<n else weight*(n-i-1) for i, weight in enumerate(seesaw)]
    # answer = [30, 0, 0, -6, -10, -24]

    # 아무것도 빼지 않는 경우
    total = sum(answer)
    if total == 0:
        return -1

    # 모든 조합에 대해 추 다 빼보기
    for n in range(1, len(indecis)+1):
        pos_comb = combinations(indecis, n) # <itertools.combinations object> -> generator 돌려줘야해 
        for comb in pos_comb:
            if total == sum(answer[i] for i in comb):
                return list(comb)

solution([10, 0, 0, 0, 1, 2])   # [0, 4, 5]
solution([10, 0, 0, 6, 5, 8])   # [4]
