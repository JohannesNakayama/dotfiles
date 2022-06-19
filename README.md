# Setup Machine

*Install and configure the basics:*

* change keyboard layout to neo2
* [install](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [setup](https://docs.github.com/en/get-started/quickstart/set-up-git) git / github
* vim (if not installed) -> nvim
* [zsh](https://gist.github.com/derhuerst/12a1558a4b408b3b2b6e)
* [zgen](https://github.com/tarjoilija/zgen)
* [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* [npm](https://linuxconfig.org/install-npm-on-linux)
* [rg](https://github.com/BurntSushi/ripgrep)
* [curl](https://curl.se/)


*Set login shell to zsh:*

* `chsh -s /bin/zsh`


*Terminal Emulator:*

* [alacritty](https://alacritty.org/)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k#zgen)
* [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)


[*Install dotfiles*](https://www.atlassian.com/git/tutorials/dotfiles):

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
echo .cfg >> .gitignore  #  important to avoid recursion troubles (see tutorial linked above)
# rm .bashrc  #  if autogenerated .bashrc
git clone --bare git@github.com:JohannesNakayama/dotfiles.git $HOME/.cfg
config checkout master
```


*Setup work environments:*

* [Julia](https://julialang.org/)
* bundle / jekyll
* R / RStudio
* sqlite3


*Install utilities:*

* [brave browser](https://brave.com/linux/)
* [fzf](https://github.com/junegunn/fzf)
* [htop](https://htop.dev/)
* [taskwarrior](https://taskwarrior.org/)
* [tmate](https://tmate.io/)
* [tmux](https://github.com/tmux/tmux/wiki)
* [tree](https://linux.die.net/man/1/tree)
* [tig](https://jonas.github.io/tig/)
* [vimwiki](https://github.com/vimwiki/vimwiki)
* [snownews](https://github.com/msharov/snownews)


*Some notes:*

* if gnome desktop is default, switch to KDE plasma
* avoid snap
* use brave profiles for separation of tasks



# Next Steps

* clean up `.config/nvim/init.vim`
* configure i3 / i3-gaps (rewrite config)

*Checkout, maybe install:*

* xmonad / i3 / i3-gaps / herbstluftwm
* scala / sbt / ammonite
* grip
* qutebrowser
* inkscape
* hnterm
* vifm
* asciinema
* wikit
