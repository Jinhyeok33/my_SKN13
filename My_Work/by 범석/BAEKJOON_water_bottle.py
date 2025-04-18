'''
먼저 같은 양의 물이 들어있는 물병 두 개를 고른다. 그 다음에 한 개의 물병에 다른 한 쪽에 있는 물을 모두 붓는다.
이 방법을 필요한 만큼 계속 한다.

이런 제약 때문에, N개로 K개를 넘지않는 비어있지 않은 물병을 만드는 것이 불가능할 수도 있다.
다행히도, 새로운 물병을 살 수 있다. 상점에서 사는 물병은 물이 1리터 들어있다.

예를 들어, N=3이고, K=1일 때를 보면, 물병 3개로 1개를 만드는 것이 불가능하다.
한 병을 또다른 병에 부으면, 2리터가 들어있는 물병 하나와, 1리터가 들어있는 물병 하나가 남는다.
만약 상점에서 한 개의 물병을 산다면, 2리터가 들어있는 물병 두 개를 만들 수 있고, 마지막으로 4리터가 들어있는 물병 한 개를 만들 수 있다.
'''

def solution(N, K):
    additional_water = 0

    while bin(n).count('1') > K:
        # n의 최하위 1 비트 추출
        least_significant_bit = n & -n
        additional_water += least_significant_bit
        n += least_significant_bit

    print(additional_water)






# number = 10

# number_to_binary = bin(number)

# for _ in number_to_binary:
#     print(_)