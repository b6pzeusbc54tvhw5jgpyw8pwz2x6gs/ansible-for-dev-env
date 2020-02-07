# ansible-for-macos
Ansible playbook and guide for quickly provisioning personal work environment when setting up MacOS.

## Preparation

```shell
$ brew install ansible python3
$ brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
$ ansible-galaxy install --roles-path=.galaxy_roles viasite-ansible.zsh
```

## Create `hosts.yml`
To define the information of the machines to be provisioned,
make `hosts.yml` file on root directory of this project like:

```yml
all:
  hosts:
    localhost:
      ansible_port: 22
      ansible_host: 127.0.0.1
      ansible_user: <your MacOS username>
```

If you encounter a connection error on first run,
- Check `Remote Login` in **System Preferences** -> **Sharing**
- Add `ECDSA` key into your `~/.ssh/known_hosts` by type `yes` in below comamnd:

```shell
$ ssh 127.0.0.1
The authenticity of host '127.0.0.1 (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:ifxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx0o.
Are you sure you want to continue connecting (yes/no)? 
```

## Execute ansible-playbook

```sh
$ ansible-playbook site.yml -i hosts.yml -k -K -v --extra-vars=@extra-vars.yml

## or you can excute only specific tagged task, using -t
$ ansible-playbook site.yml -i hosts.yml -k -K -v --extra-vars=@extra-vars.yml -t git
```

### Extra variable
To parameterize some configure, you can provide extra variables as
`--extra-vars` option.

```sh
$ ansible-playbook site.yml -i hosts.yml -k -K -v --extra-vars=@extra-vars.yml --extra-vars=@extra-vars-user.yml
```

All extra variable examples are below:
```yml
# extra-vars-user.yml (is gitignored)
EXTRA_VAR_UPDATE_VIM_PLUGIN: true     # default: false
```

## Manual settings
`ansible-playbook` 이후 해야할 수동 작업 들:

### Keyboard maestro
[keyboardmaestro][keyboardmaestro] 실행 후 System Preferences 에서 권한 부여

매크로 설정 import:

```shell
$ open config-backup.kmmacros
```

Keyboard maestro 를 설치후 위 커맨드로 import 후
disable 된 매크로들을 enable 해줘야함

### Karabiner element
[Karabiner][karabiner] 실행 후 System Preferences 에서 권한 부여

### hammerspoon
[Hammerspoon][hammerspoon] lua 스크립트 사용으로,
VIM Editor 사용시 한글 입력 후 command mode 로 나왔을 때 자동 영문 전환

### Snippets
https://www.alfredapp.com/

### iTerm color scheme
- https://iterm2colorschemes.com/
- recommend: NightLion v2, Tango Dark

[hammerspoon]: https://www.hammerspoon.org/
[keyboardmaestro]: https://www.keyboardmaestro.com/main/
[karabiner]: https://pqrs.org/osx/karabiner/

### macOS Sierra(Mojave)에서 원화(₩) 대신 백 쿼트(`) 입력하기

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

참고: 구름 입력기 사용하면 안해도 될 듯!?

