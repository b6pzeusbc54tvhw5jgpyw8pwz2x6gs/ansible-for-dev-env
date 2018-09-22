# ansible

## install role

```sh
$ ansible-galaxy install --roles-path=.galaxy_roles geerlingguy.docker
$ ansible-galaxy install --roles-path=.galaxy_roles geerlingguy.pip
$ ansible-galaxy install --roles-path=.galaxy_roles geerlingguy.ruby
$ ansible-galaxy install --roles-path=.galaxy_roles Stouts.python 
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
$ ansible-playbook site.yml -i hosts.yml -k -K -t vim --extra-vars '{"EXTRA_VAR_UPDATE_VIM_PLUGIN":true}'
```

## Tip. yaml debugging

```sh
$ npx js-yaml tasks-vim.yml
```
