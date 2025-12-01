import datetime
from db_lastConn import *
title = ['번호','이름','국어','영어','수학','합계','평균','날짜','등수','등급']

# 학생성적 정렬
def stuOrder():
   print("1. 학생이름") 
   print("2. 학생성적")
   choice = input("원하는 번호를 입력하세요.>>  ")
   conn = getConnection()
   cursor = conn.cursor()
   if choice == "1":
       query = f"select * from stuscore order by name"
       cursor.execute(query)
   else:
       query = f"select * from stuscore order by total desc"
       cursor.execute(query)
   
   rows = cursor.fetchall()
   print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}".format(*title))
   print("-"*80)
   for r in rows:
       print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
   print()    
       


#-- 학생성적 삭제 -----------------------------------
def stuDelete():
    name = input("삭제하려는 학생이름을 입력하세요.>> ")
    # 1. db연결
    conn = getConnection()
    cursor = conn.cursor()
    query = f"select * from stuscore3 where name = '{name}'"
    cursor.execute(query)
    r = cursor.fetchone()
    
    if r: # 검색해서 있을경우
        ### 출력부분
        print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}".format(*title))
        print("-"*80)
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
        print()
        choice = input("정말 학생성적을 삭제하시겠습니까?(1.삭제 0.취소) ")        
        if choice == "1":
            query = f"delete stuscore3 where name='{name}'"
            cursor.execute(query)
            conn.commit()
            print(f"{name} 학생이 성적이 삭제되었습니다. ")
        else: print(f"{name} 학생 삭제가 취소되었습니다. ")
    else:
        print("삭제하려는 학생성적이 없습니다.")    
    print()    
    conn.close()



# 3. 학생성적수정
def stuUpdate():
    ## 3.성적수정
    # 1) 학생검색
    name = input("수정하려는 학생이름을 입력하세요.>> ")
    # db연결
    conn = getConnection()
    cursor = conn.cursor()
    query = f"select * from stuscore where name like '%{name}%'"
    cursor.execute(query)
    rows = cursor.fetchall()
    # print("개수 : ",len(rows))
    # 출력부분
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}".format(*title))
    print("-"*80)
    if len(rows)>0:
        for r in rows:
            print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
        print()
        choice = input("수정하려는 학생번호를 입력하세요.>> ")        
        query = f"select * from stuscore3 where sno = {choice}"
        cursor.execute(query)
        row = cursor.fetchone()    
        if row:
            print(row)
        else:
            print("번호를 잘못 입력하셨습니다. 다시 시작해주세요.")    
                
    else:
        print("수정하려는 학생이 없습니다. 다시 검색하세요. ")
    print()
    conn.commit()
    conn.close()



## 2.성적출력
def stuOutput():
    # db연결
    conn = getConnection()
    cursor = conn.cursor()
    query = "select * from stuscore3 order by sno"
    cursor.execute(query)
    rows = cursor.fetchall()
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}".format(*title))
    print("-"*80)
    for r in rows:
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
    print()
    conn.commit()
    conn.close()


# 1. 성적입력.
def stuInput():
    name = input("이름을 입력하세요.>> ")
    kor = int(input("국어점수를 입력하세요.>> "))
    eng = int(input("영어점수를 입력하세요.>> "))
    math = int(input("수학점수를 입력하세요.>> "))
    total = kor+eng+math
    avg = total/3
    # db연결
    conn = getConnection()
    cursor = conn.cursor()
    query = f"insert into stuscore3 values (\
        stuscore3_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},\
        sysdate,0,'')"
    cursor.execute(query)
    conn.commit()
    conn.close()
    print(name,"학생성적이 입력되었습니다.")
    print()
