ansible-7days
=============
Install and configure 7 Days to Die gameserver with Ansible

![7Days](/image/7days_icon.png?raw=true "This is a really fun game")

**What does it do?**
   - Automate deployment of 7 Days to Die Server
     * Downloads and sets up SteamCMD
     * Drops in templated server configs, startup script
     * Installs 7 Days to Die Systemd services for management

**Requirements**
   - RHEL7 or CentOS7+ server/client with no modifications
     - Fedora 23 or higher needs to have ```yum python2 python2-dnf libselinux-python``` packages.
     * You can run this against Fedora clients prior to running Ansible:
     - ```ansible 7days -u root -m shell -i hosts -a "dnf install yum python2 libsemanage-python python2-dnf -y"```
   - Deployment tested on Ansible 1.9.4 and 2.0.2

**7 Days Server Instructions**
   - Clone repo and setup your hosts file
```
git clone https://github.com/sadsfae/ansible-7days
cd ansible-7days
sed -i 's/host-01/7daystodieserver/' hosts
```
   - Optionally edit server name, port or other variables here:
```
vi install/group_vars/all.yml
```
   - Run the playbook
```
ansible-playbook -i hosts install/7days.xml
```
   * On subsequent runs Ansible will simply update SteamCMD, 7days assets and
     restart the 7days systemd service.

**To Do**
   - Add optional ability to import saved games
   - Flesh out firewall rules more to include ranges
   - Expand server config variables

**File Hierarchy**
```
├── hosts
└── install
    ├── 7days.yml
    ├── group_vars
    │   └── all.yml
    └── roles
        └── 7server
            ├── files
            │   ├── 7days.service
            │   └── startserver.sh
            ├── tasks
            │   └── main.yml
            └── templates
                └── serverconfig.xml.j2
```

**7 Days to Die Live Trailer**


[![Ansible Elk](http://img.youtube.com/vi/tnKLwfAgZjI/0.jpg)](http://www.youtube.com/watch?v=tnKLwfAgZjI "7 Days to Die Live Trailer")


