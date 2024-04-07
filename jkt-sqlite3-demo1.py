from sqlite3 import *

with connect("sql-murder-mystery.db") as con:
    cur = con.cursor()
    sql = """
    SELECT count(*), car_make
    FROM drivers_license
    GROUP BY car_make
    ORDER BY count(*) DESC
    """
    res = cur.execute(sql)
    print (res)
    while True:
        row = res.fetchone()
        if row is None:
            break
        else:
            print (row)
            
        
        
    
        
    