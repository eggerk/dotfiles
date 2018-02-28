# Git
## Rebase
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
