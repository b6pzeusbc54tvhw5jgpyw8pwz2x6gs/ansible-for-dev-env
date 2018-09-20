# ansible

## install role
```sh
$ ansible-galaxy install geerlingguy.docker
$ ansible-galaxy install geerlingguy.pip
$ ansible-galaxy install geerlingguy.ruby
$ ansible-galaxy install Stouts.python
```

## hosts.yml example

```yml
all:
  hosts:
    localhost:
      ansible_port: 22
      ansible_host: 127.0.0.1
      ansible_user: ssohjiro
```

## excute

```sh
$ ansible-playbook site.yml -i hosts.yml -k -K -vv
$ ansible-playbook site.yml -i hosts.yml -k -K -t git
```

## Tip. yaml debugging

```sh
$ npx js-yaml tasks-vim.yml
```
