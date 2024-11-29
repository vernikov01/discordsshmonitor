#!/bin/bash
echo "Make sure to have inputted the webhook url in all the files in this directory before proceeding."
echo -n "Do you want to set up the logging systems? (y/n):  "
read -r response

case "$response" in
    [Yy]* )
        echo "installing now..."
        sudo apt update
        sudo apt install auditd audispd-plugins -y
        sudo systemctl enable --now auditd
        echo "-w /bin/ -p x -k ssh_commands" >> /etc/audit/rules.d/ssh-commands.rules
        mv sshc.sh /usr/local/bin/sshc.sh
        chmod +x /usr/local/bin/sshc.sh
        sudo augenrules --load
        sudo systemctl restart auditd
        mv sshc.service /etc/systemd/system/sshc.service
        sudo systemctl enable --now sshc.service
        echo "ssh command logging now set up,  try systemctl status sshc.service to confirm once script is completed."
        mv sshl.sh /usr/local/bin/sshl.sh
        chmod +x /usr/local/bin/sshl.sh
        echo "session optional pam_exec.so seteuid /usr/local/bin/sshl.sh" >> /etc/pam.d/sshd
        sudo systemctl restart sshd
        return 0
        ;;
        
    [Nn]* )
        return 1
        ;;
        
    * )
        echo "Please answer yes or no."
        ;;
esac
