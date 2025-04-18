'''
[산책]
문제 설명 
여름이는 강아지를 산책시키려고 합니다. 여름이는 2차원 좌표평면에서 동/서/남/북 방향으로 1m 단위로 이동하면서 강아지를 산책시킵니다. 
산책루트가 담긴 문자열 route가 주어질 때, 도착점의 위치를 return하도록 빈칸을 채워 solution함수를 완성해 주세요.
route는 "N", "S", "E", "W"로 이루어져 있습니다.
"N"은 북쪽으로 1만큼 움직입니다.
"S"는 남쪽으로 1만큼 움직입니다.
북쪽으로 -1만큼 움직인 것과 같습니다.
"E"는 동쪽으로 1만큼 움직입니다.
"W"는 서쪽으로 1만큼 움직입니다.
동쪽으로 -1만큼 움직인 것과 같습니다.
출발점으로부터 [동쪽으로 떨어진 거리, 북쪽으로 떨어진 거리]형태로 강아지의 최종 위치를 구해서 return해야 합니다.
출발점을 기준으로 서쪽, 남쪽에 있는 경우는 동쪽, 북쪽으로 음수만큼 떨어진 것으로 표현합니다.
출발점으로부터 동쪽으로 2, 북쪽으로 3만큼 떨어졌다면 [2, 3]을 return 합니다.
출발점으로부터 서쪽으로 1, 남쪽으로 4만큼 떨어졌다면 [-1, -4]를 return 합니다.
'''
######################################################################################
def solution(route):
    move = {'N':1, 'E':1, 'W':-1, 'S':-1}
    pos = [0, 0]

    for direction in route:
        if direction == 'E' or direction == 'W':
            pos[0] += move[direction]
        elif direction == 'N' or direction == 'S':
            pos[1] += move[direction]

    return pos

print(solution("NSSNEWWN"))  # [-1, 1]
print(solution("EESEEWNWSNWWNS"))  # [0, 0]
###################################################################################

def solution(route):
    pos = [0, 0]
    pos[0] += route.count('E') - route.count('W')
    pos[1] += route.count('N') - route.count('S')

    return pos

print(solution("NSSNEWWN"))  # [-1, 1]
print(solution("EESEEWNWSNWWNS"))  # [0, 0]


