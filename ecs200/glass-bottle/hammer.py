import os
import sys
import time

s = 'x'
count = 0

while True:
    s = s * 2
    count = count + 1
    if count % 10 == 0:
        time.sleep(30)
#    childPID = os.fork()
#    if childPID == 0:
#        print('I am running ... {0}'.format(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())))
