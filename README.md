# these files start with a •
... beginnings of my dotfiles setup for linux and osx

----

## • contents •

#### general
* atom config
* common aliases and functions

#### osx
* .profile
* iterm2 config

#### linux
* .bashrc
----
### • useful dotfile setup links •
* [iterm2 settings sync](
http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)  
* [atom sync](https://pawelgrzybek.com/sync-atom-between-multiple-devices/)
* [stratus3d dotfiles](https://github.com/Stratus3D/dotfiles)

----
### • notes2me •
* add a command reference for commonly used but often forgotten commands
* switch to zsh and integrate that config here
* adopt tmux and it's config
* write sync.sh for quick setup
* add commonly used shell scripts
    * wacom (linux)
    * screencap (linux)
* investigate storing some of maya, nuke, and mari configs
    * and possibly zbrush for osx  
* modify *.profile* and *.bashrc* to source common alias + function files
* create checks in *.profile* and *.bashrc* to set prompt coloring based on hostname

----
### • command reference •
#### file management
* copy files over ssh using `scp`
    * copy from a remote host to local:
       ```bash
        scp user@remotehost:/path/to/file /path/to/local/dir
        ````

* copy from local to a remote host: `scp /path/to/local/file user@remotehost:/path/to/dir`

#### string manipulation
* search and replace words in file(s)
```bash
sed -i 's/string_to_find/replacement_string/g' *.py
sed -i 's/string_to_find/replacement_string/g' <filename>```

* recursively find names of files containing string
```bash
grep -rl "string_to_find" .
grep -rl "string_to_find" <path>```

* recursively find files containing string and replace
```bash
grep -rl "string_to_find" <path> | xargs sed -i 's/string_to_find/replacement_string/g'```

#### file management

* recursively find and delete all files with <substring> in their name
```bash
find . -name "*<substring>*" -delete
find <path> -name "*<substring>*" -delete
```

* recursively find and delete all folders with <substring> in their name
```bash
find . -name "*<substring>*" | xargs rm -r
find <path> -name "*<substring>*" | xargs rm -r
```


#### disk management

* find size of directory
```bash
sudo du -sh <dirname>
```

* btrfs file system size
```bash
sudo btrfs fi usage <mount-point>
```

#### permissions
* recursively *chmod* all directories  
```bash
find /path/to/find -type f -exec chmod 755 {} +`
```
* recursively *chmod* all files  
```bash
find /path/to/find -type f -exec chmod 644 {} +
```
