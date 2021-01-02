# dotfiles
dotfiles
If you’re installing on a new computer, you can do the following:
```bash
$ git clone --bare <my repo> ~/.dotfiles
$ cd ~/.dotfiles
$ git config --local core.bare false
$ git config --local core.worktree <my home>
$ git config --local status.showUntrackedFiles no
$ git reset
```
These steps have cloned and set up the Git repo, but so far nothing has changed.

Now, run the following to check what will change when you “install” the dotfiles:
```
git status
```
Check you are not going to overwrite any local files with local changes you want to keep.

Beware - the next line installs the current version of files in your dotfiles repo, potentially overwriting different versions in your home directory (or subdirectories).
```bash
$ git reset --hard HEAD --
```
That’s it, your home directory is now managed by Git!

In order to manage the repo without having to `cd` to `~/.dotfiles`:

```bash
echo "alias dotgit="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"" >> $HOME/.bashrc
```
Notes

The is no `.gitignore` in this system, as Git is instructed to ignore all files that are not part of the repo.

Automation: If you want to automate adding local changes to your repo, it should be quite easy. Though, you’ll need to decide how to deal with remote changes if you are using your dotfiles on more than one computer.

Branches: If you have big differences between your needs on your various computers, you can even keep differences in branches!
