#!/bin/bash


component=$1
environment=$2
yum install python3.12-devel python3.12-pip python3-dnf ansible -y
python3.12 -m pip install botocore boto3 

ansible-pull -U  https://github.com/PrakashReddy17051997/roboshop_ansible_roles_tf.git \
    -e component=$component \
    -e env=$environment main-tf.yaml
