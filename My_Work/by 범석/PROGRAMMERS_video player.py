def solution(video_len, pos, op_start, op_end, commands):
    
    def string_time_to_int(time):
        return int(time.split(':')[0]) * 60 + int(time.split(':')[1])

    video_len_second = string_time_to_int(video_len)
    pos_second = string_time_to_int(pos)
    op_start_second = string_time_to_int(op_start)
    op_end_second = string_time_to_int(op_end)

    for command in commands:
        if pos_second >= op_start_second and pos_second <= op_end_second:
                pos_second = op_end_second
        if command == "prev":
            pos_second -= 10
            if pos_second < 10:
                pos_second = max(pos_second-10, 0)

            if pos_second >= op_start_second and pos_second <= op_end_second:
                pos_second = op_end_second
        elif command == "next":
            if pos_second >= op_start_second and pos_second <= op_end_second:
                pos_second = op_end_second
            pos_second += 10
            if pos_second > video_len_second:
                pos_second = min(pos_second, video_len_second)
            else:
                if pos_second > op_start_second and pos_second < op_end_second:
                    pos_second = op_end_second
        

    pos = str(pos_second // 60).zfill(2) + ":" + str(pos_second % 60).zfill(2)
    return pos