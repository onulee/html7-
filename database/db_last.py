# import db_lastConn
from db_lastConn import *

conn = getConnection()


#------------------------
while True:
    print("[ 학생성적처리프로그램 ]")
    print("1. 성적입력")
    print("2. 성적출력")
    print("3. 성적수정")
    print("4. 성적삭제")
    print("5. 학생검색")
    print("6. 학생정렬")
    print("7. 등수처리")
    print("0. 프로그램 종료")
    print("-"*50)
    choice = input("원하는 번호를 입력하세요.>> ")
    if choice == "1":  # 성적입력
        pass
    elif choice =="2": # 성적출력
        pass
    elif choice =="3": # 성적수정
        pass
    elif choice =="4": # 성적삭제
        pass
    elif choice =="5": # 성적검색
        pass
    elif choice =="6": # 성적정렬
        pass
    elif choice =="7": # 등수처리
        pass
    else:
        print("[ 프로그램 종료 ]")
        break
    





