ansible-7days
=============

Install and configure a [7 Days to Die](https://7daystodie.com) dedicated game
server with Ansible.

![7Days](/image/7days_icon.png?raw=true "This is a really fun game")

## What it does

- Creates a dedicated `7days` service user.
- Installs the OS dependencies SteamCMD needs.
- Downloads and sets up SteamCMD.
- Downloads the 7 Days to Die server content via SteamCMD.
- Renders a templated `serverconfig.xml`.
- Installs a systemd unit and startup script.
- Optionally restores a saved game from a local archive.
- Optionally opens the game ports with firewalld or iptables.

## Requirements

- Ansible core 2.9 or newer.
- The `ansible.posix` collection (install it first):

```bash
ansible-galaxy collection install -r requirements.yml
```

- Any modern Linux host you can reach over SSH. Ansible's `package` module picks
  the package manager automatically (yum, dnf, or apt), so the distribution does
  not matter. The 32-bit library names in `sdtd_packages` are the EL/Fedora ones;
  on a Debian/Ubuntu host, adjust them to that distro's 32-bit packages.

## Usage

1. Clone the repo and set your server host in `hosts`:

```bash
git clone https://github.com/sadsfae/ansible-7days
cd ansible-7days
# edit hosts, set the 7days.example.com line to your server
```

2. Review the deployment variables in `install/group_vars/all.yml` and set a real
   `server_pass` (and `control_panel_password`).

3. Optionally edit role defaults in
   `install/roles/7server/defaults/main.yml` (ports, world, difficulty, etc.).

4. Run the playbook:

```bash
ansible-playbook -i hosts install/7days.yml
```

To restore a saved game archive (e.g. a `7d2d.tgz`) into the server's save folder,
point `upload_local_save` at it:

```bash
ansible-playbook -i hosts install/7days.yml -e upload_local_save=/path/to/7d2d.tgz
```

On subsequent runs Ansible only updates SteamCMD, the game content and the
service as needed.

## Firewall

By default the playbook does **not** touch the firewall (`sdtd_firewall: none`).
After a successful first deploy, open the game ports explicitly by setting in
`install/group_vars/all.yml`:

```yaml
sdtd_firewall: firewalld   # or "iptables"
```

The ports opened are `seven_port` (udp), `data_port` (udp) and `admin_port`
(tcp).

## File hierarchy

```
├── hosts
├── requirements.yml
└── install
    ├── 7days.yml
    ├── group_vars
    │   └── all.yml
    └── roles
        └── seven_server
            ├── defaults
            │   └── main.yml
            ├── files
            │   ├── 7days.service
            │   └── startserver.sh
            ├── handlers
            │   └── main.yml
            ├── tasks
            │   └── main.yml
            └── templates
                └── serverconfig.xml.j2
```

## Credits

The saved-game import and the configurable game tunables were contributed by
[aknauf](https://github.com/aknauf) in
[#1](https://github.com/sadsfae/ansible-7days/pull/1).

## License

Apache-2.0
