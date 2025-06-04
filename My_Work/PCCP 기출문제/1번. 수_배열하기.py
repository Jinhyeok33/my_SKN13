# 수 배열하기
# 1차원 배열 nums와 그 크기 n에 대해 배열의 자연수들을 다음과 같이 정렬한다.
# 만일 숫자를 n으로 나누는 나머지를 인덱스로 가지는 자리가 비어있다면 해당 자리에 숫자를 넣는다.
# 만일 해당 자리가 이미 다른 숫자로 채워져있다면, 비어있는 자리 중 가장 작은 인덱스에 숫자를 넣는다.
# 정렬된 배열을 반환해라.
def solution(nums):
    n = len(nums); idx = 0
    answer = [-1 for _ in range(n)]
    for num in nums:
        if answer[num%n] == -1:
            answer[num%n] = num
        else:
            while True:
                if answer[idx] == -1:
                    answer[idx] = num
                    break
                else:
                    idx += 1
    return answer
solution([8, 11, 1, 23, 4, 13, 4]) # [1, 8, 23, 4, 11, 4, 13]
