#!/usr/bin/env bash
# Argument #1 - host FQDN

os=$(ansible ${1} --private-key=~/.ssh/id_rsa -i inventory -u rutomo --become -m setup -a 'filter=ansible_os_family' --vault-password-file=.vault_file_password | cut -d\> -f 2 | jq -Mr .ansible_facts.ansible_os_family)

if [[ "$os" == "Debian" ]]; then
  group="sudo"
else
  group="wheel"
fi

ansible ${1} --private-key=~/.ssh/id_rsa -i inventory -u rutomo --become -m ansible.builtin.user -a "name=ansible append=yes groups='${group}' ssh_key_bits=2048 state=present" --vault-password-file=.vault_file_password
ansible ${1} --private-key=~/.ssh/id_rsa -i inventory -u rutomo --become -m ansible.builtin.lineinfile -a "path=/etc/sudoers line='ansible ALL=(ALL) NOPASSWD:ALL'" --vault-password-file=.vault_file_password
ansible ${1} --private-key=~/.ssh/id_rsa -i inventory -u rutomo --become -m ansible.builtin.file -a "path=/home/ansible/.ssh/ state=directory mode=0700 owner=ansible group=ansible" --vault-password-file=.vault_file_password
ansible ${1} --private-key=~/.ssh/id_rsa -i inventory -u rutomo --become -m ansible.builtin.copy -a "src=/Users/rutomo/.ssh/ansible.pub dest=/home/ansible/.ssh/authorized_keys mode=0600 owner=ansible group=ansible" --vault-password-file=.vault_file_password
