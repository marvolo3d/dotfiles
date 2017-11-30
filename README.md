# these files start with a •
something something dotfiles (linux and osx)

----

## • contents •

#### general
* zsh and oh-my-zsh config
* atom config
* *Maya.env* and maya startup script *userSetup.py*
* *houdini.env*
* *sync.sh* to sync all dotfiles (incomplete)

#### osx
* iterm2 config

#### linux
* no penguin specifics yet

----
### • useful dotfile setup links •
* [iterm2 settings sync](
http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)  
* [atom sync](https://pawelgrzybek.com/sync-atom-between-multiple-devices/)
* [stratus3d dotfiles](https://github.com/Stratus3D/dotfiles)

----
### • notes2me •
* ~~add a command reference for commonly used but often forgotten commands~~
    * this is wip - will split out of README into separate files
    * add git command reference
* tmux
* write sync.sh for quick setup
* add commonly used shell scripts
    * wacom (linux)
    * screencap (linux)
* investigate storing some of ~~maya~~, ~~houdini~~, nuke, and mari configs
    * and possibly zbrush for osx  

----
### • command reference •
* all commands should work on both linux and osx unless noted otherwise
* will update some of this with zsh goodies sometime
#### string manipulation - search and replace

* search and replace words in file(s)
    ```bash
    sed -i 's/string_to_find/replacement_string/g' *.py
    sed -i 's/string_to_find/replacement_string/g' <filename>
    ```
* recursively find names of files containing string
    ```bash
    grep -rl "string_to_find" .
    grep -rl "string_to_find" <path>
    ```
* recursively find files containing string and replace
    ```bash
    grep -rl "string_to_find" <path> | xargs sed -i 's/string_to_find/replacement_string/g'
    ```

#### file management

* recursively find and delete all files with `<substring>` in their name
    ```bash
    find . -name "*<substring>*" -delete
    find <path> -name "*<substring>*" -delete
    ```
* recursively find and delete all folders with <substring> in their name
    ```bash
    find . -name "*<substring>*" | xargs rm -r
    find <path> -name "*<substring>*" | xargs rm -r
    ```
* copy files over `ssh` using `scp`  
    * copy from a remote host to local: `scp user@remotehost:/path/to/file /path/to/local/dir`
    * copy from local to a remote host: `scp /path/to/local/file user@remotehost:/path/to/dir`
    * `-r` flag to copy dirs, just like regular cp
* operate on all files recursively (any command)
    * something like `find /path/to/find <options> -exec <command>`??
        * not certain of exact exec syntax  

#### disk management

* find size of directory: `du -sh <dirname>`
* btrfs file system size: `sudo btrfs fi usage <mount-point>`

#### permission management - chmod and chown

* recursively `chmod` all directories: `find /path/to/find -type f -exec chmod 755 {} +`
* recursively `chmod` all files: `find /path/to/find -type f -exec chmod 644 {} +`
* change owner and group of file or directory: `chown newUser:newGroup <target>`

#### nfs exports
* nfs exports live in */etc/exports*
* update exports with `exportfs -ra`
* macos mount linux nfs share: `nfs://hostname:sharename`

----
####  • other useful references, cheatsheets and resources •
##### markdown
* [adam-p markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
##### python
 * [PEP 8 style guide for python code](https://www.python.org/dev/peps/pep-0008/)
 * [PEP 257 docstring conventions guide](https://www.python.org/dev/peps/pep-0257/)
##### zsh
* [zsh installation](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)
