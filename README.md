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
```

### extra variable
To parameterize some configure, you can provide extra variables as
`--extra-vars` option.

```sh
$ ansible-playbook site.yml -i hosts.yml -k -K --extra-vars=@.extraValue.yml
```

All extra variable examples are below:
```yml
# .extraValue.yml (is gitignored)
EXTRA_VAR_UPDATE_VIM_PLUGIN: true                         # default: false
EXTRA_VAR_PROXY_SERVER_URL: http://123.123.123.123:8080/  # default: ''
EXTRA_VAR_CA_CERT: |                                      # default: ''
    -----BEGIN CERTIFICATE-----
    MIIEzTCCA7WgAwIBAgIMVWI2fkPCMs08osgOMA0GCSqGSIb3DQEBCwUAMEwxCzAJ
    BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlB
    bHBoYVNTTCBDQSAtIFNIQTI1NiAtIEcyMB4XDTE2MDcyNDA0MzI1NloXDTE3MDcy
    NTA0MzI1NlowNzEhMB8GA1UECxMYRG9tYWluIENvbnRyb2wgVmFsaWRhdGVkMRIw
    EAYDVQQDDAkqLmRldnAubWUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
    AQC+aAHKrXRzb+Dey87VfwdrIp699Cdf/bQJqNUkL3auZUQaFrZh/7KlB9HgBNJ/
    EK7drxW8teR3Zpz/WHxz+5e4aX60vXucdfiyIg7DPHX8nxEoFYD9W9CHlnGAXQcB
    bvwvGW5eMx5lxFh6BQEmiblKii3y0/w1duU2A6RS3eIkN7QZZIzAN+mhYS35+rDH
    dAYEWIh9HGM4LSs0RbpYA8x88TdoJ/SAFHsaaoqkkkkzW2EKr8xztbo0UAdaV3sa
    +IA9HLOnNnjWrABy42zADShM2dObnNS6zcYXegZS+jxT2t7m0iIFQBdbIOymzye9
    9gxYys+LdKV3fpvsW9PPrHFLAgMBAAGjggHCMIIBvjAOBgNVHQ8BAf8EBAMCBaAw
    yXvQdjBielj8eWa3RojGApedMrJhjdt4GBHh4fFc2Vty
    -----END CERTIFICATE-----
ansible_python_interpreter: "/usr/bin/python3"
```

## Tip. yaml debugging

```sh
$ npx js-yaml tasks-vim.yml
```
