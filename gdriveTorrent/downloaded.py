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

        #Run gdrive command and upload the file:"./downloads/fileName" to gdrive
        script = 'gdrive upload -p 0BxvPH5Yx_NkmRzluTk9sLTlMUXc "%s%s"'%(path,fileName)
        logFile = open('outputGdrive.txt','w')
        process = Popen(script, shell = True, stdout=logFile, stderr=logFile)

        #Delete the uploaded file from ./downloads folder, after the subprocess is completed
        poll = process.poll()
        while poll == None:
            poll = process.poll()
            continue
        script = 'rm -rf "%s%s"'%(path,fileName)
        os.system(script)


#If another instance of this script is already running, exit
def running():
    script_name = 'downloaded.py'
    try:
        l = commands.getstatusoutput("ps aux | grep -e '%s' | grep -v grep | awk '{print $2}'| awk '{print $2}'" % script_name)
    except:
        return False
    if l[1] != '\n' and l[1]:
        print 'Already running'
        return True
    else:
        print 'Not Running'
        return False

if not running():
    uploadFiles()
