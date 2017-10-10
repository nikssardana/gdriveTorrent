# Gdrive Torrent

## Introduction
A Django Application that allows you to download torrents directly to your Google Drive. It is useful for use when you are behind a firewall that does not allow torrents to be downloaded directly.

## Requirements
- python2 (https://www.python.org/downloads/)  
- virtualenv (https://pypi.python.org/pypi/virtualenv)
- aria2 - a terminal based torrent client (https://aria2.github.io/)
- gdrive - a command line utility to access gdrive from your command line (https://github.com/prasmussen/gdrive)

## Running the code on your local system

### Easy install

```
bash -c "$(curl -sL https://raw.githubusercontent.com/nikssardana/gdriveTorrent/master/install.sh)"
```

#### Note: (Tested on ubuntu)

apt-get/yum packages are not installed automatically due to security concerns, the installer will inform you of any packages missing (if there are any), but here is a list of packages needed:
```
sudo apt-get install python-pip python-dev build-essential aria2 git wget -y && sudo pip install virtualenv
```

After setup is complete, you may start the server at any time (or have a job do it) by running:

```
install.sh start_server
```

### Manual install

- Currently, the code must be cloned in a specific directory to run it. (E.g: /home/nikhil/Programs/Django/gdriveTorrent)

    `cd into the cloned folder.`
- Add executable permissions to downloaded.py file by typing:

    `sudo chmod +x downloaded.py`

- Initialise the gdrive utility by typing:

    `gdrive init`

- Open the url specified in `gdrive` and give appropriate permissions.

- Then, copy the access token from your browser and paste it into the terminal.

- Create a database:

    `Env/bin/python gdriveTorrent/manage.py migrate`

- Create a superuser:

    `Env/bin/python gdriveTorrent/manage.py createsuperuser`

- Run the django development server:

    `sudo Env/bin/python gdriveTorrent/manage.py runserver 0.0.0.0:8000`

- Open the url: *your ip address:8000* in your browser and login with the admin credentials you just created.

## Note
This application is currently in development phase. There might be a lot of bugs.

Pull requests are welcome!

Also, I do not promote any illegal use of this application. Use wisely!

Please make changes in a separate branch and then make pull requests.

## Features to be implemented
- Improve documentation
- Extend the application to allow multiple users. The application should ask for write access to gdrive. It should then download the files on their gdrive instead of the developer's gdrive.
- One click deploy option, so that users can deploy the application on their own servers (heroku or any other server)
- Currently, the status of all the commands are stored in separate files (output.txt, gDriveOutput.txt and done.txt). Store it in a database and show it in the webpage.
