[TOC]

This project is using for setting up the servers automatically.

# Specifications

Currently, we are serving 2 applications, include:

- **chat** - an application to transfer messages to several flatforms (facebook, line, skype, embeded chatbox)
- **chatbot editor** - manage all chat's workflows to integrate with chat

Therefore, we will have 3 server's group corresponding to 3 missions

- **chat** - serving chat's API application
- **chatbot** - serving chatbot's API application
- **webhook** - handling jobs queue and incoming webhooks from external services (line, skype, facebook, chatbox)

# Prerequisites

You must have a knowledge on using SSH and Ansible to cover all your contents

- [SSH](https://www.ssh.com/ssh/config/) - to manage configurations (access code, PEM, ...) to interact with the servers
- [Ansible](http://docs.ansible.com/) - to manage and deploy your configurations, inlude:
  - [Ansible Galaxy](http://docs.ansible.com/ansible/latest/galaxy.html) - a package manager for ansible
  - [Ansible Playbook](http://docs.ansible.com/ansible/latest/playbooks.html) - to manage configurations of and deployments to remote machines

# Set up

### Add your SSH configs on **~/.ssh/config**

```
#!bash
Host jis2_dev_chat_1
  HostName 11.22.33.44 # server-ip
  User ubuntu # Default user
  Port 22
  IdentityFile ~/.ssh/jis2/
```

### Install Ansible and the relevant libs by using [the guide](http://docs.ansible.com/ansible/latest/intro_installation.html)

```
#!bash
# Example on MacOS
$ sudp pip install ansible
```

### Listed you hosts in the inventories

We have several hosts file (**inventories/< env >/hosts**) corresponding to each environment. Those hosts was grouped by it's mission

```
#!bash
# Example on inventories/dev/hosts
[chat]
jis2_dev_chat_1

[webhook]
jis2_dev_webhook_1

[chatbot]
jis2_dev_chatbot_1
```

### Check the environment on each inventory (advanced)

Each group (chat, webhook, chatbot) have its own configurations.  
You could find more details on looking at **inventories/< env >/group_vars** directory.  
Since we collected all required configurations, this folder is advanced an no need to change

# Installation

### Use ansible-galaxy to install all required ansible's packages

```
#!bash
$ ansible-galaxy install -r requirements.yml
```

### Use ansible-playbook to deploy your configs to the server

The below is related to:

- **playbook-name** means **server's group**
- **inventory-name** means **target environment {dev/prod}**

```
#!bash
# Set up for all server's group
# ansible-playbook <playbook-name> -i <inventory-name>
$ ansible-playbook main.yml -i inventories/dev

# Set up for specific server's group
# ansible-playbook <playbook-name> -i <inventory-name>
$ ansible-playbook main.yml -i inventories/dev

# pass extra-vars
$ ansible-playbook main.yml -i inventories/dev --extra-vars "@vars.json"
```

### All things have done!
