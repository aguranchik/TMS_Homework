import os
from time import sleep
import json

filename = "host_account.json"

class Account():
    """Class to Create users accounts"""
    def __init__(self, host, uname, password):
        """Initiate account"""
        self.host = host
        self.uname = uname
        self.password = password

    def show_account(self):
        """Print all parametr of account"""
        discription = ("Host: " + self.host + "\tUsername: " + self.uname + "\tPassword: " + self.password)
        print (discription)

    def obj_to_json(self):
        """Convert obj to json"""
        return json.dumps(self.__dict__)

def test_accounts ():
    accounts = []
    accounts.append(Account("prod-mysql-node-01","root","password"))
    accounts.append(Account("prod-mysql-node-01","dbreader","password"))
    accounts.append(Account("prod-mysql-node-01","dbwriter","password"))
    accounts.append(Account("prod-mysql-node-02","root","password"))
    accounts.append(Account("prod-mysql-node-02","dbreader","password"))
    accounts.append(Account("prod-mysql-node-02","dbwriter","password"))
    return accounts

def write_acc_list_to_file (list):
    myfile = open(filename,mode='w',encoding='utf-8')
    acc_json = []
    for i in range(len(list)):
        acc_json.append(list[i].obj_to_json())
    json.dump({"total": i+1,"result": acc_json}, myfile,indent=4,ensure_ascii = False)
    myfile.close()

def add_acc_list_to_file (account):
    list = file_to_acc_list () 
    list.append(account)
    myfile = open(filename,mode='w',encoding='utf-8')
    acc_json = []
    for i in range(len(list)):
        acc_json.append(list[i].obj_to_json())
    json.dump({"total": i+1,"result": acc_json}, myfile,indent=4,ensure_ascii = False)
    myfile.close()

def file_to_acc_list ():
    myfile = open(filename,mode='r',encoding='utf-8')
    acc_json = json.load(myfile)
    accounts = []
    for i in range(acc_json['total']):
        accounts.append(Account(json.loads(acc_json['result'][i])['host'],json.loads(acc_json['result'][i])['uname'],json.loads(acc_json['result'][i])['password']))
    myfile.close()
    return accounts


write_acc_list_to_file (test_accounts ())
while True:
    try:
        os.system('cls||clear')
        print("""
        \t1. Add account
        \t2. Print list of accounts
        \t3. Search by username
        \t4. Search by hostname
        \t5.Exit/Quit
        """)
        my_var = int(input("Enter an integer number " ))
    except ValueError:
        continue
    else:
        if my_var == 1:
            add_acc_list_to_file (Account(input("Enter hostname: "),input("Enter username: "),input("Enter password: ")))
            sleep(2)
        elif my_var ==2:
            list = file_to_acc_list ()
            for i in range(len(list)):
                print (list[i].uname + "@" + list[i].host)
            sleep(10)
        elif my_var ==3:
            name = (input("Enter username: "))
            list = file_to_acc_list ()
            for i in range(len(list)):
                if name == list[i].uname:
                    print (list[i].uname + "@" + list[i].host)
            sleep(10)
        elif my_var ==4:
            name = (input("Enter hostname: "))
            list = file_to_acc_list ()
            for i in range(len(list)):
                if name == list[i].host:
                    print (list[i].uname + "@" + list[i].host)
            sleep(10)
        elif my_var ==5:
            sleep(2)
            exit()
        else:
            continue