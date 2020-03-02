# Introduction

## Unifi Playbook

This playbook is to deploy Unifi Controller on Ubuntu based machine.  It's tested with the following Ubuntu version:
- 18.04

In general, the playbook will do the followings:
* Install UFW package and reject all
* Allow port 22 on UFW
* Install Unifi Controller and allow necessary ports
* Provision Let's Encrypt wildcard domain cert using DNS validation on Cloudflare
* Install Nginx, setup as a proxy for Unifi Controller and allow ports for http and https

### Pre-requisites
There are a few requirements in order to run this playbook:
* ansible v2.9.4 (developed with this version so no guarantee older version will work). refer to [Ansible doc](https://docs.ansible.com/ansible/latest/installation_guide/index.html) on how to install it
* `ansible` user is setup on remote host with passwordless ssh and sudo

To run the playbook, simply use the following command
```
git clone git@github.com:rutomo/ansible-playbook.git
cd ansible-playbook
mv sample-env .env #populate necessary environment variables
ansible-playbook install-unifi.yml
```
