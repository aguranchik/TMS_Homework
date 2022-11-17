import os
from time import sleep

from random2 import randint

while True:
    my_vars = [ ]
    max_var = 10
    rand_var = randint(0,max_var)

    while True:
        try:
            os.system('cls||clear')
            print ("My values:", my_vars)
            my_var = int(input("Enter an integer from 0 to " + str (max_var) + ": " ))
        except ValueError:
            continue
        else:
            if my_var > rand_var:
                print ("Your value is greater than expected")
                my_vars.append (str(my_var) + ">x")
                sleep(3)
            elif my_var < rand_var:
                print ("Your value is less than expected")
                my_vars.append (str(my_var) + "<x")
                sleep(3)
            else:
                print ("Your value is correct")
                if input ("Do you want to continue? (Enter 'y' for continue): " ) == 'y':
                    break
                else:
                    exit()