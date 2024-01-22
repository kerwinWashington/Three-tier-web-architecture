#!/bin/bash
sudo yum update
sudo yum install -y amazon-efs-utils
sudo mkdir efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport {CHANGEIP}:/ efs