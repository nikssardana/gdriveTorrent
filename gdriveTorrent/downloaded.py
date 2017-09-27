#!/usr/bin/python

#Script to be run on-bt-download-complete of aria2c

f = open('done.txt','a')
f.write('COMPLETED')


#TODO: Aria2c on-complete will run a python script that will find out newly added file in download folder;run gdrive command and upload it there; and delete the file from ./downloads folder
