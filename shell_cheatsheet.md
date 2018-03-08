# Table of Contents
- [Linux tools](#linux-tools)
- [Git](#git)

# Linux tools
- *[Table of Contents](#table-of-contents)*
- [find](#find)

## find
- *[Linux tools](#linux-tools)*

General syntax:
```bash
find $search_folder -name $search_name -exec $command {} +
```

### type flag
Use `-type $type` to set the the type of the files to be searched. Possible values:
- `d` directory
- `f` regular file
- `l` symbolic link
- and more

# Git
- *[Table of Contents](#table-of-contents)*
- [Rebase](#rebase)

## Rebase
- *[Git](#git)*

### Change base branch
Convert
```
(commit 1) - master
                \-- (commit 2) - (commit 3) - first_branch
                                                \-- (commit 4) - (commit 5) - second_branch
```
to
```
(commit 1) - master
                |-- (commit 2) - (commit 3) - first_branch
                \-- (commit 4) - (commit 5) - second_branch
```

**Do:**
```bash
git checkout second_branch
git rebase --onto master first_branch second_branch
```
(Source: https://stackoverflow.com/questions/10853935/change-branch-base)
