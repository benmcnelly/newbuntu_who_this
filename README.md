# newbuntu_who_this

Minimal bootstrap script to turn a fresh Ubuntu server into a usable, styled terminal environment using **Oh My Posh**.

## What this does

* Installs core packages (`curl`, `git`, `unzip`)
* Installs **oh-my-posh**
* Sets up a my preferred look

## Usage

```bash
curl -fsSL https://raw.githubusercontent.com/benmcnelly/newbuntu_who_this/main/bootstrap-terminal.sh | bash
```

Will be active on next time you connect or

```bash
bash bootstrap-terminal.sh
source ~/.bashrc
```


---

## Requirements

* Ubuntu (tested on 20.04+)
* Bash shell
