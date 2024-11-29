# Monitor ssh logins and sessions live from discord 
scripts to set up live monitoring of ssh sessions on a debian based server

1. clone the repo
`git clone https://github.com/vernikov01/discordsshmonitoring.git`

2. cd into directory
`cd discordsshmonitoring`

3. edit sshl.sh and sshc.sh and input your discord webhook link on the line WH="webhookurl" where webhookurl should be replaced with your discord webhook
4. make setup.sh executeable
`chmod +x setup.sh`
5. execute setup.sh
`./setup.sh`
