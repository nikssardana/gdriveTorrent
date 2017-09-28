#!/usr/bin/python

#Script to be run on-bt-download-complete of aria2c

import os
import sys
from subprocess import Popen
import subprocess
import commands

f = open('done.txt','a')
f.write('\nFILES: ')

def uploadFiles():
    #Get list of files in download folder
    #TODO: Change directory on server
    path = '/home/nikhil/Programs/Django/gdriveTorrent/gdriveTorrent/downloads/'
    files = os.listdir(path)
    for fileName in files:
        f.write(fileName)

        #Run gdrive command and upload the file "./downloads/fileName"
        script = 'gdrive upload -p 0BxvPH5Yx_NkmRzluTk9sLTlMUXc %s%s > gdriveOutput.txt'%(path,fileName)
        #Output logs to a file
        os.system(script)

    #Delete the uploaded file from ./downloads folder
    script = 'rm %s%s'%(path,fileName)
    os.system(script)


#If another instance of this script is already running, exit
def running():
    script_name = 'downloaded.py'
    l = commands.getstatusoutput("ps aux | grep -e '%s' | grep -v grep | awk '{print $2}'| awk '{print $2}'" % script_name)
    if l[1] != '\n' and l[1]:
        print 'Already running'
        return True
    else:
        print 'Not Running'
        return False

if not running():
    uploadFiles()
