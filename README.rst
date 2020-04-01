Overview
========

First run
---------
.. code::

    wget https://raw.githubusercontent.com/gravelweb/autoconfig/master/bootstrap.sh
    bash bootstrap.sh  # Run once to perform initial software configuration.
    bash bootstrap.sh  # Run again to complete configuration.
    bash bootstrap.sh extra=<extra>  # To install extra config.

Some configuration requires that the system be rebooted.

WSL
---
This command can also be used in WSL when using Gnome-Terminal over X server:

Create and configure Ubuntu WSL (replace <username> in the last line with
username to use).
.. code::

    wsl --import UbuntuEoan Q:\Dev\wsl\UbuntuEoan Q:\Dev\wsl\.rootfs\eoan-server-cloudimg-amd64-wsl.rootfs.tar.gz
    wsl -d UbuntuEoan

    tee ~/.wsl-setup.sh <<_EOF
    #!/bin/bash
    new_user=$1
    adduser "${new_user}"
    adduser "${new_user}" sudo
    tee /etc/wsl.conf <<_EOF
    [user]
    default=${new_user}
    _EOF
    chmod a+x ~/.wsl-setup.sh

    ./wsl-setup.sh <username>

Shutdown WSL distro for changes to /etc/wsl.conf to take effect.
.. code::

    wsl --shutdown UbuntuEoan

Create a shortcut with the following Target:

C:\Windows\System32\wsl.exe -d UbuntuEoan -- DISPLAY=192.168.100.123:0 gnome-terminal --working-directory=~

You can pin this shortcut to the taskbar to find it quickly.
