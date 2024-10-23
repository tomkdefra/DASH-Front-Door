---
title: "Git on RStudio"
permalink: /set-up/git-on-rstudio/
---

The DASH Platform RStudio server enables integration with GitHub. To set this up:

1. Include your username and email in git config.

```
git config --global user.name 'username'
git config --global user.email 'first_name.surname@defra.gov.uk' 
```

This will help you avoid having issues when performing `git push` operations allowing a clear commit history.


2. When you run a git push, either through the git commit pane or through running `git push` in the terminal. RStudio will ask for a user name which will be your GitHub username and then a password, which will be a [personal access token (PAT)](https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) - This PAT will expire on a frequency defined during it's set-up so will need to be refreshed periodically.

3. The GUI will remember your PAT so you should not need to re-enter this each time. 
