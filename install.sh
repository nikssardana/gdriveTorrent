#!/bin/bash -e
red="tput setaf 1"
green="tput setaf 2"
yellow="tput setaf 3"
reset="tput sgr0"

#find tools
python=$(which python)
git=$(which git)

#locations
install_dir="${HOME}/Programs/Django"
git_repo="https://github.com/nikssardana/gdriveTorrent.git"
gdriveURL="https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"


start_server(){
$python $install_dir/gdriveTorrent/gdriveTorrent/manage.py runserver 0.0.0.0:8000;
exit 1
}

if [  ! -z $1 ]; then
  if [ -f ~/.finished_setup ]; then

    if [ "$1" == "start" ]; then
      start_server
    else
      $red
      echo "unable to start webserver on port 8000..."
      $reset
      exit 1
    fi

  else
    $red
    echo "must have run setup first to start server, exiting..."
    $reset
    exit 1
  fi
else
  :
fi

$green
echo "##########################"
echo "# gdriveTorrent Installer"
echo "##########################"
$reset

sleep 2

if [ -f ~/.finished_setup ]; then
  $yellow
  echo "This script has ran before, are you sure you want to run again? (y,n)"
  $reset
  read answer
  if [ "$answer" == "y" ]; then
    :
  else
    $red
    echo "Unrecognized input, Bye."
    $reset
    exit 1
  fi
fi

#remove repo if cloned before
if [ -d $install_dir ];then
    rm -rf $install_dir/
else
  :
fi

#verify os, user
if [ $(uname -m) == "x86_64" ]; then
  :
else
  $red
  echo "64 bit os required."
  $reset
  exit 1
fi

if [ "$(id -u)" != "0" ]; then
  echo
  $red
  echo "Must be root to run this script."
  $reset
  exit 1
fi

## test if dependencies are installed

# test python, if pip installed, install virtualenv
if which python 1>/dev/null; then
  if which pip 1>/dev/null; then
    $green
    echo "Upgrading pip...."
    echo
    $reset
    pip install --upgrade pip 1>/dev/null
    if pip install virtualenv 1>/dev/null; then
      $green
      echo "Installing virtualenv...."
      echo
      $reset
    else
      $red
      echo "Could not install virtualenv."
      $reset
      exit 1
    fi
  else
    $red
    echo "pip not installed, please install then re-run script. (sudo apt-get update && sudo apt-get install python-pip python-dev build-essential -y)"
    $reset
    exit 1
  fi
else
  $red
  echo "python not installed, please install then re-run script."
  $reset
  exit 1
fi


if which git 1>/dev/null; then
  :
else
  $red
  echo "git not installed, please install then re-run script."
  $reset
  exit 1
fi

if which wget 1>/dev/null; then
  $green
  echo "Downloading gdrive..."
  wget -q $gdriveURL -O /usr/bin/gdrive && chmod +x /usr/bin/gdrive

  if [ $? == 0 ]; then
    echo
    $green
    echo "gdrive downloaded successfully"
    echo
    $reset
  else
    $red
    echo "gdrive download failed, exiting..."
    $reset
    exit 1
  fi

  $reset
else
  $red
  echo "wget not installed, please install then re-run script."
  $reset
  exit 1
fi

if which aria2c 1>/dev/null; then
  :
else
  $red
  echo "aria2c not installed, install by running, (sudo apt-get install aria2 -y), then re-run this script."
  $reset
  exit 1
fi

if [ -d $install_dir ];then
    :
else

  $green
  echo "Install directory does not exist, creating..."
  echo
  $reset

  if mkdir -p $install_dir; then
    :
  else
    $red
    echo "Failed to create ${install_dir}, exiting..."
    $reset
    exit 1
  fi
fi

$green
cd $install_dir && $git clone $git_repo 1>/dev/null
echo
$reset

if [ $? == 0 ]; then
  :
else
  $red
  echo "git clone failed, exiting..."
  $reset
  exit 1
fi

if [ -d $install_dir/gdriveTorrent/gdriveTorrent ];then
    chmod +x $install_dir/gdriveTorrent/gdriveTorrent/downloaded.py
else
  $red
  echo "Directory structure incorrect, please verify that ${install_dir}/gdriveTorrent/gdriveTorrent is the way it should be, exiting..."
  $reset
  exit 1
fi

$yellow
echo
echo "initializing gdrive, have your browser + gmail ready!"
echo
$reset

sleep 3

if gdrive list; then
  $green
  echo "gdrive initialized!"
  echo
  $reset
else
  $red
  echo "failed to initialize gdrive, exiting..."
  $reset
  exit 1
fi

if pip install Django 1>/dev/null; then
  $green
  echo "Django installed!"
  echo
  $reset
else
  $red
  echo "failed to install Django, exiting..."
  $reset
  exit 1
fi

if $python $install_dir/gdriveTorrent/gdriveTorrent/manage.py migrate; then
  $green
  echo "Created Database"
  echo
  $reset
else
  $red
  echo "Failed to create Database, exiting..."
  $reset
  exit 1
fi

if $python $install_dir/gdriveTorrent/gdriveTorrent/manage.py createsuperuser; then
  $green
  echo "Created superuser"

  if sudo chown -R $(whoami):$(whoami) $install_dir/ && sudo chmod -R 755 $install_dir/; then
    $yellow
    echo
    echo "Changed permissions on to $(whoami):$(whoami) - 755 on ${install_dir}."
    echo
    $reset
  else
    $red
    echo "Failed to set permissions to $(whoami):whoami and chmod 755 on ${install_dir}, login may not work correctly..."
    $reset
  fi

  $green
  echo
  echo "##################################################"
  echo "# Setup Done - Navigate to http://localhost:8000 #"
  echo "##################################################"
  echo
  $reset
else
  $red
  echo "Failed to create superuser, exiting..."
  $reset
  exit 1
fi

if $python $install_dir/gdriveTorrent/gdriveTorrent/manage.py runserver 0.0.0.0:8000; then
:
else
  $red
  echo "Failed to create webserver, exiting..."
  $reset
  exit 1
fi

touch ~/.finished_setup
$reset
exit 0
