# gitea-docker

## Generate selfsigned cert

You may create selfsigned cert first for using HTTPS.

./gen-selfsigned-cert.sh

## Git service passthrough

Create git user account.
```
sudo adduser git
```
Edit the git user's UID GID in docker-compose.yml

You can use this command to show the UID and GID
```
id -u git
id -g git
```
Edit docker-compose.yml
```
environment:
 - USER_UID=1001
 - USER_GID=1001
```
Generate git user's SSH key.
```
sudo -u git ssh-keygen -t rsa -b 4096 -C "Gitea Host Key"
```
Register key to authorized_keys
```
sudo -u git cat /home/git/.ssh/id_rsa.pub | sudo -u git tee -a /home/git/.ssh/authorized_keys
sudo -u git chmod 600 /home/git/.ssh/authorized_keys
```
Add create the fake host gitea command
```
cat <<"EOF" | sudo tee /usr/local/bin/gitea
#!/bin/sh
ssh -p 2222 -o StrictHostKeyChecking=no git@127.0.0.1 "SSH_ORIGINAL_COMMAND=\"$SSH_ORIGINAL_COMMAND\" $0 $@"
EOF
sudo chmod +x /usr/local/bin/gitea
```

## Deploy service using docker compose

After that deploy services
```
docker compose up -d
```
Stop the service
```
docker compose stop
```
Start the service
```
docker compose start
```
Remove the service
```
docker compose down
```

## Connect to ther service

Open the web browser and open the service

```
https://localhost
```

Enjoy.
