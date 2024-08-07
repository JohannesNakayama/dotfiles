# Dotfiles

This is how I setup my computer.
I took a lot of inspiration from the following dotfiles repositories:

* https://github.com/fdietze/dotfiles
* https://github.com/notusknot/dotfiles
* https://gitlab.com/protesilaos/dotfiles

Feel free to take mine as an inspiration as well.

**Install**

This is not guaranteed to work for anyone anywhere, nor is it supposed to.
These are just my instructions for myself.
Requires root user privileges.

```
mkdir -p \
  ~/Documents \
  ~/Downloads \
  ~/Other \
  ~/Pictures \
  ~/Projects \
  ~/Sync

# Add config repo to gitignore important to avoid recursion troubles
echo .cfg >> .gitignore

# If autogenerated .bashrc exists, delete it
rm .bashrc

# Install dotfiles
git clone --bare https://github.com/JohannesNakayama/dotfiles.git $HOME/.cfg
alias cfg='/run/current-system/sw/bin/git --git-dir=/home/johannes/.cfg/ --work-tree=/home/johannes'
cfg config --local status.showUntrackedFiles no
cfg checkout master

# Download alacritty themes
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# Install zgen for zsh plugin management
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

# Create symlinks for nix configuration
cp /etc/nixos/hardware-configuration.nix $HOME/.config/nixos
mv /etc/nixos /etc/nixos.bak
ln -s $HOME/.config/nixos /etc/nixos
```

**Notes**

* [neo2](https://neo-layout.org/) keyboard layout
* maybe learn [qutebrowser](https://qutebrowser.org/) or [vimb](https://fanglingsu.github.io/vimb/)
* rss reader: [snownews](https://github.com/msharov/snownews)

**Useful Resources**

* [setting up git](https://docs.github.com/en/get-started/quickstart/set-up-git)
    * [setup authentication](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
    * [add ssh keys to github and gitlab](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
* [manage ssh keys with keepassxc](https://ferrario.me/using-keepassxc-to-manage-ssh-keys/)
* [enable flakes on nixos](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled)
* postgres [installation](https://adamtheautomator.com/install-postgresql-on-a-ubuntu/) and [setup](https://www3.ntu.edu.sg/home/ehchua/programming/sql/PostgreSQL_GetStarted.html)
* [use neo2 arrow keys in Intellij idea](https://youtrack.jetbrains.com/issue/IDEA-256569#focus=Comments-27-4579814.0-0)

**Useful Browser Extensions**

* [remove all distractions from YouTube](https://unhook.app/)
* [keyboard-based browsing](https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=de%2F)
* [narrower text for better readability](https://chromewebstore.google.com/detail/narrower/jfjaedekncgddegockpigkkpgkhaoljg?hl=de%2F)
