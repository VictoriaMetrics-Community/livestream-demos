# Victorialogs quickstart

## Install Victorialogs with Ansible
1. Install Ansible
2. Install dependancies `ansible-galaxy collection install -r requirements.yml`
3. Change the host in `ansible/inventory.yml` to the host of your Victorialogs server
4. Deploy Victorialogs `ansible-playbook -i inventory.yml deployment.yml --ask-become-pass`
5. Confirm you can see the Victorialogs UI  by `http://<ip_or_host>:9428/select/vmui`


## Ingestion logs
1. Install rsyslog
2. Add the following to `/etc/rsyslog.d/50-livestream.conf`
```
# Enable imfile module
module(load="imfile")

# Forward syslog to Telegraf
*.* action(type="omfwd" Target="krista.local.shiftsystems.net" Port="5140" Protocol="udp" Template="RSYSLOG_SyslogProtocol23Format")

# Scrape Proxmox Access Log
input(type="imfile" File="/var/log/pveproxy/access.log" Tag="pve-access" Severity="info" Facility="local7")
input(type="imfile" File="/var/log/pveam.log" Tag="pveam" Severity="info" Facility="local7")
input(type="imfile" File="/var/log/pve-firewall.log" Tag="pve-firewall" Severity="info" Facility="local7")
input(type="imfile" File="/var/log/pve/tasks/active" Tag="pve-tasks" Severity="info" Facility="local7")
```
3. Restart Rsyslog `sudo systemctl rsyslog`
4. look for logs in VMUI by running the query `*`
5. If there are no logs generate some by logging into proxmox and checking for updates
