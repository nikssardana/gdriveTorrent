#!/usr/bin/python

#Script to be run on-bt-download-complete of aria2c

import os
import sys
from subprocess import Popen
import subprocess


f = open('done.txt','a')
f.write('\nFILES: ')

def uploadFiles():
    #Get list of files in download folder
    #TODO: Change directory on server
    files = os.listdir('/home/nikhil/Programs/Django/gdriveTorrent/gdriveTorrent/downloads/')
    for fileName in files:
        f.write(fileName)
        #TODO:run gdrive command and upload the file "./downloads/fileName"

    #TODO:Delete the uploaded file from ./downloads folder

#If another instance of this script is already running, exit
import commands
import os
import time
import sys

def running():
    script_name = 'downloaded.py'
    l = commands.getstatusoutput("ps aux | grep -e '%s' | grep -v grep | awk '{print $2}'| awk '{print $2}'" % script_name)
    print(l)
    if l[1] != '\n' and l[1]:
        print 'Already running'
    else:
        print 'NOT RUNNING'

if not running():
    uploadFiles()
