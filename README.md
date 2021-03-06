# ansible-for-dev-env
Ansible playbook and guide for quickly provisioning personal work environment when setting up MacOS.

## Preparation
Tested on Ansible 2.9.x, 2.10.x.

### Install Ansible

**For MacOS user:**
```shell
$ brew install ansible python3
```

**For Ubuntu user:**

```
$ sudo apt install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible python3
```

Reference: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu

### Install dependency
In this repo's root directory,

```
$ ansible-galaxy install --roles-path=.galaxy_roles viasite-ansible.zsh
```

### Connection
If you encounter a connection error on first run,
- (Only MacOS) Check `Remote Login` in **System Preferences** -> **Sharing**
- Add `ECDSA` key into your `~/.ssh/known_hosts` by type `yes` in below comamnd:

```shell
$ ssh 127.0.0.1
The authenticity of host '127.0.0.1 (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:ifxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx0o.
Are you sure you want to continue connecting (yes/no)?
```

- Add current user's key into itself `~/.ssh/authorized_keys` file:
```
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

If `No such file or directory` error occurs,
first you need to generate SSH Key like this:
```
$ ssh-keygen
## Then just input 'Enter' continuously without passphrase for your convenience.
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
# password to run sudo.
# If the current user can use sudo without a password, it can be omitted.
ansible_become_pass: '<user-sudo-password>'

# If "Incorrect su password" error occurs, try belows:
ansible_become_method: su
ansible_become_user: root
ansible_become_pass: '<root-password>'

# for Ubuntu
ansible_python_interpreter: /usr/bin/python3  # this overwrite vars.yml's value

# optional variables:
EXTRA_VAR_UPDATE_VIM_PLUGIN: true          # default: false
EXTRA_VAR_NO_SPECIAL_CHAR_IN_PROMPT: true  # default: false
```

## Execute ansible-playbook

```sh
# for MacOS 10.15
$ ansible-playbook site-macos-10.15.yml -v -u $USER --ask-vault-pass

# for Ubuntu 16 or 18
$ ansible-playbook site-ubuntu-16-or-18.yml -v -u $USER --ask-vault-pass

## or you can excute only specific tagged task, using -t
$ ansible-playbook <site-xxx.yml> -v -u $USER --ask-vault-pass -t git
```

### (Only MacOS) Insecure directories and files 문제

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
`ansible-playbook` 실행 후 해야 할 수동 작업 들:

### Install Node, Terraform, Docker and so on...


**Install node:**
```
$ nvm ls-remote --lts
$ nvm install <node-version>
$ nvm use <node-version>
```

**(Only Ubuntu) Install yarn:**
```
$ npm install --global yarn
```

**Install terraform:**
```
$ tfenv list-remote
$ tfenv install <terraform-version>
$ tfenv use <terraform-version>
```

> if Command not found error occurs,
> close the shell(ssh) and try again after reconnecting.

**(Only Ubuntu) Install Docker:**
- https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script

```
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
$ sudo usermod -aG docker $USER
```

### (Only MacOS) Preferences Keyboard setting
- Preferences - Keyboard - Adjust `Key Repeat`, `Delay Until Repeat`
- Preferences - Keyboard - Modifier Keys... - Caps Lock Key: `No Action`
- Preferences - Keyboard - Text - uncheck: `Use smart quotes and dashes`

### (Only MacOS) Keyboard maestro

매크로 설정 import:

```shell
$ open config-backup.kmmacros
```
Keyboard maestro 를 설치후 위 커맨드로 import 후
disable 된 매크로들을 enable 해줘야함

### (Only MacOS) Snippets
https://www.alfredapp.com/

### (Only MacOS) iTerm color scheme
- https://iterm2colorschemes.com/
- recommend: NightLion v2, Tango Dark

### (Only MacOS) VS Code, IntelliJ 등에서 key press and hold 안되는 문제

```
$ defaults write -g ApplePressAndHoldEnabled -bool false
```

- https://stackoverflow.com/a/44010683

### (Only MacOS) macOS Sierra(Mojave)에서 원화(₩) 대신 백 쿼트(`) 입력하기

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

**참고:**
- 구름 입력기 사용자는 환경설정에서 `한글 입력기일 때 역따옴표로 원화 기호 입력` 을 체크 해제로 같은 효과

### References
- https://ani2life.com/wp/?p=1753
- https://gist.github.com/redism/43bc51cab62269fa97a220a7bb5e1103
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_vault.html#running-a-playbook-with-vault

[keyboardmaestro]: https://www.keyboardmaestro.com/main/
[karabiner]: https://pqrs.org/osx/karabiner/

