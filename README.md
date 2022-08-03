# Setup Machine

* change keyboard layout to neo2 (probably during installation)

* make directories:

```
mkdir ~/Projects ~/Work ~/utilities
```

* install:

```
sudo apt install \
    bspwm \
    curl \
    dmenu \
    feh \
    fzf \
    git \
    htop \
    i3lock \
    imagemagick \
    neovim \
    picom \
    polybar \
    postgresql \
    postgresql-client \
    postgresql-contrib \
    python3-pip \
    ripgrep \
    sqlite3 \
    sxhkd \
    tig \
    tmate \
    tmux \
    tree \
    zsh \
```

* install:
    * [brave browser](https://brave.com/linux/)
    * [docker](https://docs.docker.com/engine/install/ubuntu/)

* [setup git](https://docs.github.com/en/get-started/quickstart/set-up-git)
    * [setup authentication](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
    * [add ssh keys to github and gitlab](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

* set login shell to zsh:

```
chsh -s /bin/zsh
```

* [install dotfiles](https://www.atlassian.com/git/tutorials/dotfiles):

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
echo .cfg >> .gitignore  #  important to avoid recursion troubles (see tutorial linked above)
rm .bashrc  #  if autogenerated .bashrc exists
git clone --bare git@github.com:JohannesNakayama/dotfiles.git $HOME/.cfg
config checkout master
config config --local status.showUntrackedFiles no
```

* install into `~/utilities`:
    * [alacritty](https://alacritty.org/)
    * [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
    * [zgen](https://github.com/tarjoilija/zgen)

* pip environments:

```
pip3 install pipenv
```

* install:
    * [Julia](https://julialang.org/)
    * R / RStudio


### Optional

* bundle / jekyll
* [cfiles](https://github.com/mananapr/cfiles)
    * set image preview program to w3m (otherwise, you get stuck when navigating to image files)
* [npm](https://linuxconfig.org/install-npm-on-linux)
* [taskwarrior](https://taskwarrior.org/)
* [snownews](https://github.com/msharov/snownews)


### Some notes

* avoid snap
* use brave profiles for separation of tasks
* [use neo2 arrow keys in Intellij idea](https://youtrack.jetbrains.com/issue/IDEA-256569#focus=Comments-27-4579814.0-0)
* postgres [installation](https://adamtheautomator.com/install-postgresql-on-a-ubuntu/) and [setup](https://www3.ntu.edu.sg/home/ehchua/programming/sql/PostgreSQL_GetStarted.html)


## Next Steps

*Checkout, maybe install:*

* grip
* qutebrowser


## For Reference

* [bspwm](https://github.com/baskerville/bspwm)
* [curl](https://curl.se/)
* dmenu
* [feh](https://feh.finalrewind.org/)
* [fzf](https://github.com/junegunn/fzf)
* [htop](https://htop.dev/)
* [i3lock](https://github.com/i3/i3lock)
* [neovim](https://neovim.io/)
* [picom](https://github.com/yshui/picom)
* [polybar](https://github.com/polybar/polybar)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k#zgen)
* [rg](https://github.com/BurntSushi/ripgrep)
* sqlite3
* [sxhkd](https://github.com/baskerville/sxhkd)
* [tig](https://jonas.github.io/tig/)
* [tmate](https://tmate.io/)
* [tmux](https://github.com/tmux/tmux/wiki)
* [tree](https://linux.die.net/man/1/tree)
* [vimwiki](https://github.com/vimwiki/vimwiki)
* [zsh](https://gist.github.com/derhuerst/12a1558a4b408b3b2b6e)

