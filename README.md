# ansible

## install role
```
$ ansible-galaxy install geerlingguy.docker
$ ansible-galaxy install geerlingguy.pip
$ ansible-galaxy install geerlingguy.ruby
$ ansible-galaxy install viasite-ansible.zsh
```

## hosts.yml example

```
all:
  hosts:
    localhost:
      ansible_port: 22
      ansible_host: 127.0.0.1
      ansible_user: ssohjiro
```

## excute

```
$ ansible-playbook site.yml -i hosts.yml -k -K -vw
$ ansible-playbook site.yml -i hosts.yml -k -K -t git
```

## Tip. yaml debugging

```
$ npx js-yaml tasks-vim.yml
```
