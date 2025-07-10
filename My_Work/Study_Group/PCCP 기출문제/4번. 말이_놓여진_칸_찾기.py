# 말이 놓여진 칸 찾기
# 노드와 간선으로 이루어진 그래프 구조에서 (start, end)로 이루어진 양방향 간선 전체가 2차원 배열로 주어진다.
# 특정 노드에만 말이 놓여져 있으며, 어느 노드에 놓여져 있는지는 알지 못한다. 말은 말이 놓여져 있는 칸으로 이동하지 못한다.
# 또한, 주어진 그래프 구조에서 가능한 모든 말의 이동이 담긴 (start, end)로 이루어진 일방향 간선이 2차원 배열로 주어진다.
# 말이 놓여져 있는 노드를 1, 아닌 노드를 0 으로 하는 1차원 배열을 반환하여라.
def solution(nodes, edges):
    # 그래프 구조 만들기
    answer = {}
    for start, end in nodes:
        if answer.get(start-1, 0) == 0:
            answer[start-1] = []
        if answer.get(end-1, 0) == 0:
            answer[end-1] = []
        answer[start-1].append(end)
        answer[end-1].append(start)
    # answer = {0: [2, 3, 4], 1: [1, 4], 2: [1], 3: [1, 2]}

    # 말이 놓여져 있는지 여부를 확인 1/0
    results = [0 for _ in range(len(answer.keys()))]
    # results = [0, 0, 0, 0]

    # 말이 이동할 수 있는 칸 제외
    for start, end in edges:
        answer[start-1].remove(end)
        answer[end-1].remove(start)    
        results[start-1] = 1

    # 말이 놓여져 있는 노드 중, 말이 가지 못하는 곳 찾기 
    for i, result in enumerate(results):
        if result:
            for num in answer[i]:
                results[num-1] = 1
    return results

solution([[1, 2], [1, 3], [1, 4], [2, 4]], [[1, 2], [1, 4]]) # [1, 0, 1, 0]
solution([[1, 2], [1, 3], [2, 3], [2, 5], [3, 7], [4, 5], [4, 6], [4, 7], [5, 7], [6, 7]], [[5, 2], [7, 3]]) # [0, 0, 0, 1, 1, 1, 1]
