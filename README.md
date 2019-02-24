# ansible-for-macos

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



## 별도 MACOS 설정

### macOS Sierra에서 원화(₩) 대신 백 쿼트(`) 입력하기

```bash
#!/bin/bash
if [ -f ~/Library/KeyBindings/DefaultkeyBinding.dict ]; then
	echo "~/Library/KeyBindings/DefaultkeyBinding.dict already exists"
	exit -1
fi

mkdir -p ~/Library/KeyBindings
cat << EOF > ~/Library/KeyBindings/DefaultkeyBinding.dict 
{
    "₩" = ("insertText:", "\`");
}
EOF

echo "Done."
```

출처:
- https://ani2life.com/wp/?p=1753
- https://gist.github.com/redism/43bc51cab62269fa97a220a7bb5e1103



### VIM Editor 사용시 한글 입력 후 command mode 로 나왔을 때 자동 영문 전환
[Hammerspoon][hammerspoon] 스크립트 사용

~/.hammerspoon/init.lua:
```
local caps_mode = hs.hotkey.modal.new()
local inputEnglish = "com.apple.keylayout.ABC"

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

vimSwitchMode = hs.hotkey.bind({'control'}, 'c', function()
  -- print("in off_caps_mode")
  local win = hs.window.focusedWindow()
  local app = win:application()
  local title = app:title()

  -- print( "win:title: " .. win:title() )
  -- print( "path: " .. app:path() )
  -- print( "pid: " .. app:pid() )
  -- print( "title: " .. title )
  caps_mode:exit()

  -- print( input_source )
  local input_source = hs.keycodes.currentSourceID()
  supportTitleArr = { 'iTerm2', 'Code', 'IntelliJ IDEA' }

  if (input_source ~= inputEnglish and has_value(supportTitleArr,title)) then
    -- print("switch input and vim mode")
    hs.eventtap.keyStroke({}, 'right')
    hs.keycodes.currentSourceID(inputEnglish)
    hs.eventtap.keyStroke({}, 'escape')
  else
    vimSwitchMode:disable()
    hs.eventtap.keyStroke({'control'}, 'c')
    vimSwitchMode:enable()
  end
end)

-- https://johngrib.github.io/blog/2017/08/07/hammerspoon-tutorial-05/

```

[hammerspoon]: https://www.hammerspoon.org/
