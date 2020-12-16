# ansible-for-macos
Ansible playbook and guide for quickly provisioning personal work environment when setting up MacOS.

## Preparation

```shell
$ brew install ansible python3
$ ansible-galaxy install --roles-path=.galaxy_roles viasite-ansible.zsh
```

### Connection
If you encounter a connection error on first run,
- Check `Remote Login` in **System Preferences** -> **Sharing**
- Add `ECDSA` key into your `~/.ssh/known_hosts` by type `yes` in below comamnd:

```shell
$ ssh 127.0.0.1
The authenticity of host '127.0.0.1 (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:ifxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx0o.
Are you sure you want to continue connecting (yes/no)?
```

- Add current user's key into itself `~/.ssh/authorized_keys` file
```
$ ssh-keygen  # passphrase 입력 없이 Enter 연속 입력
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

### Extra variable
You need to provide the `ansible_become_pass` variable as an encrypted file.

```
$ ansible-vault create vars-user.yml
New Vault password: `<Temporary password>`
Confirm New Vault password: `<Temporary password>`
```

Then, when the editor opens, write the following:
```
# required variables:
ansible_become_pass: '<user-sudo-password>'

# optional variables:
EXTRA_VAR_UPDATE_VIM_PLUGIN: true     # default: false
```

## Execute ansible-playbook

```sh
$ ansible-playbook site.yml -v -u $USER --ask-vault-pass

## or you can excute only specific tagged task, using -t
$ ansible-playbook site.yml -v -u $USER --ask-vault-pass -t git
```

### Insecure directories and files 문제

[insecure directories and files](https://github.com/zsh-users/zsh-completions/issues/433) 문제로
**Reset antigen cache** task등에서 진행이 막혔을 때,

** 확인: **
```
$ compaudit
There are insecure directories:
/usr/local/share/zsh/site-functions
/usr/local/share/zsh
```

** 해결: **
```
$ compaudit | xargs chmod g-w
```

## Manual settings
`ansible-playbook` 이후 해야할 수동 작업 들:

### Preferences Keyboard setting
- Preferences - Keyboard - Adjust `Key Repeat`, `Delay Until Repeat`
- Preferences - Keyboard - Modifier Keys... - Caps Lock Key: `No Action`
- Preferences - Keyboard - Text - uncheck: `Use smart quotes and dashes`

### Keyboard maestro

매크로 설정 import:

```shell
$ open config-backup.kmmacros
```
Keyboard maestro 를 설치후 위 커맨드로 import 후
disable 된 매크로들을 enable 해줘야함

### Snippets
https://www.alfredapp.com/

### iTerm color scheme
- https://iterm2colorschemes.com/
- recommend: NightLion v2, Tango Dark

### VS Code, IntelliJ 등에서 key press and hold 안되는 문제

```
$ defaults write -g ApplePressAndHoldEnabled -bool false
```

- https://stackoverflow.com/a/44010683

### macOS Sierra(Mojave)에서 원화(₩) 대신 백 쿼트(`) 입력하기

- TODO: Catalina에서 동작 확인 필요

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

### References
- https://ani2life.com/wp/?p=1753
- https://gist.github.com/redism/43bc51cab62269fa97a220a7bb5e1103
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_vault.html#running-a-playbook-with-vault

**참고:**
- 구름 입력기 사용자는 환경설정에서 `한글 입력기일 때 역따옴표로 원화 기호 입력` 을 체크 해제로 같은 효과

[keyboardmaestro]: https://www.keyboardmaestro.com/main/
[karabiner]: https://pqrs.org/osx/karabiner/

