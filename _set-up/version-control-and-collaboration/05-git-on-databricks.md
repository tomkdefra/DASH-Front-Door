---
title: "Git on Databricks"
permalink: /set-up/git-on-databricks/
---

GitHub can be integrated in DataBricks through **settings>user settings>Git integration**.

1. select provider "GitHub" - Or other provider as required.
2. Set user name.
3. Include a [personal access token (PAT)](https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) - This PAT will expire on a frequency defined during it's set-up so will need to be refreshed periodically.

Databricks' "Git Folders" feature allows users to integrate Databricks notebooks and other files directly with a Git repository. This enables version control, collaboration, and tracking of changes within the Databricks environment.