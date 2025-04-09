
def select_all_customer():
    """
    고객 전체 정보를 조회해서 반환하는 함수.
    Args:
    Returns:
    Raises:
    """
    pass

def update_customer(customer_id, name, email, tall, birthday):
    """
    고객정보를 수정하는 함수.
    Args:
    Returns:
    Raises:
    """
    sql = ('update customer '
           'set name=%s, email=%s, tall=%s, birthday=%s where id = %s')
    with pymysql.connect(host='127.0.0.1', port=3306, user='jin', password='1111', db='my_db') as conn:
        with conn.cursor() as cursor:
            result = cursor.excute(sql, [name, email, tall, birthday, customer_id])
            conn.commit()
            return result
