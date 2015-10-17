#!/usr/bin/env python
# -*- encoding:utf-8 -*-

import time
import os
import sys

def get_pid():
   print "pid:" + str(os.getpid())

print "start"
get_pid()

i=0
#while True:
for i in range(100):
#   print str(i) # 改行を出力するまで表示されない
#   print str(i)
   sys.stdout.write("\r%s" % str(i))
   sys.stdout.flush() # バッファリングされるためバッファをフラッシュしないとターミネルに表示されない
   i += 1
   time.sleep(0.1)
   if (i%10 == 0):
#     sys.stdout.write("\n")
      pass
   
print ""
print "end"
