# these files start with a •
... beginnings of my dotfiles setup for linux and osx

----

## • contents •

#### general
* atom config

#### osx
* .profile
* iterm2 config

#### linux
* .bashrc
* .alias

----
### • useful dotfile setup links •
* [iterm2 settings sync](
http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)  
* [atom sync](https://pawelgrzybek.com/sync-atom-between-multiple-devices/)
* [stratus3d dotfiles](https://github.com/Stratus3D/dotfiles)

----
### • notes2me •
* split .alias into multiple files - common (osx and lin), and os specific
    * sourced from .bashrc and .profile
* ~~add a command reference for commonly used but often forgotten commands~~
    * this is wip - may split out of README into separate files
    * add git command reference
* zsh
* tmux
* write sync.sh for quick setup
* add commonly used shell scripts
    * wacom (linux)
    * screencap (linux)
* investigate storing some of maya, houdini, nuke, and mari configs
    * and possibly zbrush for osx  
* modify *.profile* and *.bashrc* to source common alias + function files
* create checks in *.profile* and *.bashrc* to set prompt coloring based on hostname

----
### • command reference •
all commands should work on both linux and osx unless noted otherwise
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

#### permission managment - chmod and chown

* recursively `chmod` all directories: `find /path/to/find -type f -exec chmod 755 {} +`
* recursively `chmod` all files: `find /path/to/find -type f -exec chmod 644 {} +`
* change owner and group of file or directory: `chown newUser:newGroup <target>`

#### nfs exports
* nfs exports live in */etc/exports*
* update exports with `exportfs -ra`
* macos mount linux nfs share: `nfs://hostname:sharename`

#### other useful references, cheatsheets and resources
* [adam-p markdown cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
