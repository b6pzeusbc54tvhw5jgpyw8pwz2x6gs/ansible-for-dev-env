# ansible

## install role

```sh
$ git submodule update --init
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
```

### only specific tagged role

```sh
$ ansible-playbook site.yml -i hosts.yml -k -K -t git
```

### extra variable
To parameterize some configure, you can provide extra variables as
`--extra-vars` option.

```sh
$ ansible-playbook site.yml -i hosts.yml -k -K --extra-vars=@.extra-variables.yml
```

All extra variable examples are below:
```yml
# .extra-variables.yml (is gitignored)
EXTRA_VAR_UPDATE_VIM_PLUGIN: true                         # default: false
EXTRA_VAR_PROXY_SERVER_URL: http://123.123.123.123:8080/  # default: ''
EXTRA_VAR_CA_CERT: |                                      # default: ''
  -----BEGIN CERTIFICATE-----
  MIIDDTCCAfWgAwIBAgIJAPVdfW7Vqb0bMA0GCSqGSIb3DQEBCwUAMDYxFjAUBgNV
  BAMMDW15LWRvbWFpbi5jb20xHDAaBgNVBAoME2Zvci1kZXYtZW52aXJvbm1lbnQw
  IBcNMTkwNjA2MDQ0NDE4WhgPMjExOTA1MTMwNDQ0MThaMDYxFjAUBgNVBAMMDW15
  LWRvbWFpbi5jb20xHDAaBgNVBAoME2Zvci1kZXYtZW52aXJvbm1lbnQwggEiMA0G
  CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDetPHWwSWaMQjmpkZoW74HY94FKbO4
  deqywnhalyfZUn1NVI65BSukVWBzwjdut27cU2oqi4gaihRLVXE6hmBWSDwi6ds7
  iP7TvF8aZeRRIn4hE1PIm4/Hn0jwT6JbB57niCkKEUBaVlFMZ8iQotLGuYNT76bZ
  WR88Hwt05U20pqNg0Kcnf2JVz8GWnA/zk6NXx/Opnw1FUD6xDxsfNXuzScSUnDui
  03lTADvWaHNpmfGOnzDZjFnv0BZLihTziibunVAK1+McCQSKK9t0/3V44xh/1eZs
  mINQZtAl0z6BTR7PxGiaWC3fZaHGxzHpt+nOk/aMwho8N+8+c2Fu6Aj1AgMBAAGj
  HDAaMBgGA1UdEQQRMA+CDW15LWRvbWFpbi5jb20wDQYJKoZIhvcNAQELBQADggEB
  AH5r+oRbECGAYQmO8MrsLdyx8GFqMCjSQQ9bG8a9D3h3NL61TrMUAlRL4C9TukJh
  fonKDNfeOJMccH8Z4SYmbMJ8CNwRDeywaMn3Dv9xu2652Nnu2Z/GdlTs5/PDQ9XB
  pFrgJB6KZZg7QNW/DfexdcvoL4M4vsZikzkMMMq6L+IXaUoCLsLSiueIV9k8pv4+
  TsrOQl4/7mZsGewydiDWXRAzmgycd0YSYuc68PXTY2qZH6x3/iBnyIdGNp4ip8gK
  tcMnnCnSFciV/sP4U7/UO6w/mga91bxZIrjWyFgf+fCtqd7u6BWHOuioDN8kMAma
  PToE44k32PNZw2HamggV9+Q=
  -----END CERTIFICATE-----
ansible_python_interpreter: "/usr/bin/python3"
```

