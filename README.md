# Gdrive Torrent

## Introduction
A Django Application that allows you to download torrents directly to your Google Drive. Useful for use when you are behind a firewall that does not allow torrents to be downloaded directly.

## Requirements
- python2 (https://www.python.org/downloads/)  
- virtualenv (https://pypi.python.org/pypi/virtualenv)
- aria2 - a terminal based torrent client (https://aria2.github.io/)
- gdrive - a command line utility to access gdrive from your command line (https://github.com/prasmussen/gdrive)

## Running the code on your local system
- Right now, the code must be cloned in a specific directory to run it. (E.g: /home/nikhil/Programs/Django/gdriveTorrent)

 `cd into the cloned folder.`
- Add executable permissions to downloaded.py file by typing:

    `sudo chmod +x downloaded.py`
    
- Initialise the gdrive utility by typing:
    
    `gdrive init`

- Open the url specified in `gdrive` and give appropriate permissions.

- Then, copy the access token from your browser and paste it into the terminal.

Create database:

    `Env/bin/python gdriveTorrent/manage.py migrate`

- Create a superuser:

    `Env/bin/python gdriveTorrent/manage.py createsuperuser`

- Run the django development server:

    `Env/bin/python gdriveTorrent/manage.py runserver 0.0.0.0:8000` 

- Open the url: *localhost:8000* in your browser and login with the admin credentials you just created.

## Note
This application is currently in development phase. There might be a lot of bugs.

Pull requests are welcome!

Also, I do not promote any illegal use of this application. Use wisely!



Please make changes in a separate branch and then make pull requests.

## Features to be implemented
- Improve documentation
- Remove dependency on path (/nikhil/Programs...) to allow the application to run in any directory
- Extend the application to allow multiple users. The application should ask for write access to gdrive. It should then download the files on their gdrive instead of the developer's gdrive.
- One click deploy option, so that users can deploy the application on their own servers (heroku or any other server)
- Currently, the status of all the commands are stored in separate files (output.txt, gDriveOutput.txt and done.txt). Store it in a database and show it in the webpage.
