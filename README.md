ansible-7days
=============
Install and configure 7 Days to Die gameserver with Ansible

![7Days](/image/7days_icon.png?raw=true "This is a really fun game")

**What does it do?**
   - Automate deployment of 7 Days to Die Server
     * Downloads and sets up SteamCMD
     * Authorizes via Steamguard to pull down 7 Days to Die assets
     * Drops in templated server configs, startup script
     * Installs 7 Days to Die Systemd services for management

**Requirements**
   - RHEL7 or CentOS7+ server/client with no modifications
     - Fedora 23 or higher needs to have ```yum python2 python2-dnf libselinux-python``` packages.
       * You can run this against Fedora clients prior to running Ansible:
       - ```ansible fedora-client-01 -u root -m shell -i hosts -a "dnf install yum python2 libsemanage-python python2-dnf -y"```
   - Deployment tested on Ansible 1.9.4 and 2.0.2

**7 Days Server Instructions**
   - Clone repo and setup your hosts file
```
git clone https://github.com/sadsfae/ansible-7days
cd ansible-7days
sed -i 's/host-01/7daystodieserver/' hosts
```
   - Add your Steam ID and password here:
```
sed -i 's/steam_user:/steam_user: YOURUSER/' install/group_vars/all.yml
sed -i 's/steam_pass:/steam_pass: YOURPASS/' install/group_vars/all.yml
```
   - Run the playbook
```
ansible-playbook -i hosts install/7days.xml
```
   - The first playbook run will download and setup SteamCMD
   - It will also trigger steamguard, so you'll need to check your email

![7Days](/image/steam_auth.png?raw=true "Enter this code in install/group_vars/all.yml.")

   - Add the Steamguard code sent via email 
```
sed -i 's/steam_code:/steam_code: STEAMCODE/' install/group_vars/all.yml
```
   - Run Ansible one more time
```
ansible-playbook -i hosts install/7days.yml
```
   * On subsequent runs Ansible will simply update SteamCMD, 7 days assets and
     restart the 7days systemd service.

**To Do**
   - Add optional ability to import saved games
   - Flesh out firewall rules more to include ranges
   - Expand server config variables

**File Hierarchy**
```
├── hosts
├── image
│   └── steam_auth.png
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
                ├── serverconfig.xml.j2
                └── update_server.txt.j2
```

**7 Days to Die Live Trailer**


[![Ansible Elk](http://img.youtube.com/vi/tnKLwfAgZjI/0.jpg)](http://www.youtube.com/watch?v=tnKLwfAgZjI "7 Days to Die Live Trailer")


