# 유령찾기
# 무한히 큰 격자모양의 맵에서 1번~N번 플레이어가 랜덤으로 배치된다.
# 해당 플레이어는 자신 기준 위, 아래, 양옆만을 볼 수 있으며 플레이어들이 현재 자리에서 보이는 다른 플레이어의 번호를 담은 2차원 배열이 주어진다.
# 유령은 어느 플레이어의 변호든 따라할 수 있으며 다른 플레이어가 유령을 볼 때 구분하지 못한다.
# 유령이 따라한 플레이어의 번호를 반환하고, 그 번호를 특정할 수 없다면 -1를 반환해라.
def solution(players):
    n = len(players)
    answers = players.copy()
    try:
        for i, player in enumerate(players):
            for num in player:
                answers[i].remove(num)
                answers[num-1].remove(i+1)
    except:
        return num
    return sum(num for answer in answers for num in answer)

solution([[2], [1, 1], [4], [3]])       # 1
solution([[4], [3, 4], [2, 4], [1, 2]]) # 4
## for 구문에서 돌고있는 iterable을 수정할 경우, 중간에 수정된 값으로 돌아 
