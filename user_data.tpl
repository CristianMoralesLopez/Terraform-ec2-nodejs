#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt-get update -y 
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt install ansible -y
echo "#provisioning the backend

-
  hosts: localhost
  become: yes
  become_user: root
  become_method: sudo
  name: install dependencies and run the application
  tasks:
    - name: Execute update command
      shell: apt update

    -  name: install nodejs, npm and git
       apt:
         pkg:
         - nodejs
         - npm
         - git

    -  name: clone repository
       git:
         repo: https://github.com/CristianMoralesLopez/movie-analyst-api.git
         dest: /home/ubuntu/backend
         clone: yes
         
    -  name: execute npm install
       npm: 
         path: /home/ubuntu/backend
         

    - name: Execute a command using the shell module
      shell: node /home/ubuntu/backend/server.js" > localhostBackEnd.yml
ansible-playbook localhostBackEnd.yml