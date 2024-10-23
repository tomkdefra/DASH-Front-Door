---
title: "The 5 Essential Git Commands That Will Change Your Life"
permalink: /set-up/git-5-commands/
---

Git is a powerful version control system that can seem overwhelming at first, but the truth is, you only need to learn a handful of commands to improve the way you work. These essential Git commands will help you track changes, collaborate with others, and maintain a clean project history—all without needing to dive into Git’s more complex features.

## 1. `git clone`
- **What It Does:** Creates a copy of an existing Git repository on your local machine and sets up the remote connection.
- **Why It's Essential:** When starting work on an existing project or creating a new repository on GitHub, `git clone` is often the best starting point. It not only downloads the entire project history and files to your computer but also automatically sets up the remote connection to the repository.

    ```bash
    git clone https://github.com/username/repository.git
    ```

- **Note:** Replace the URL with the actual repository URL you want to clone.

## 2. `git add`
- **What It Does:** Stages changes to be committed. You can stage specific files, or all changes at once.
- **Why It’s Essential:** This command lets you choose which changes you want to include in your next commit. It’s like preparing your changes to be saved in the project history.

    ```bash
    git add <filename>   # Stages a specific file
    git add .            # Stages all changes in the directory
    ```

## 3. `git status`
- **What It Does:** Displays the state of your working directory and staging area.
- **Why It’s Essential:** If you're not sure what to do, run `git status`. This command shows you which files are tracked, which are untracked, and which changes have been staged for commit. It’s an essential tool for staying on top of what’s happening in your project.

    ```bash
    git status
    ```

## 4. `git commit`
- **What It Does:** Records your staged changes to the repository with a message describing what you’ve done.
- **Why It’s Essential:** Commits are the snapshots of your project’s history. With each commit, you document what you’ve done, allowing you to go back and see the state of your project at any point in time.

    ```bash
    git commit -m "Your descriptive message here"
    ```

## 5. `git push`
- **What It Does:** Uploads your local commits to a remote repository, like GitHub.
- **Why It’s Essential:** `git push` allows you to back up your code, share your work with others, and collaborate on projects. Without it, your commits would stay on your local machine and wouldn’t be available to the rest of your team.

    ```bash
    git push origin main   # Pushes commits to the main branch of the remote repository
    ```

## 6. `git pull`
- **What It Does:** Fetches and merges changes from a remote repository into your current branch.
- **Why It’s Essential:** `git pull` ensures that your local repository is up-to-date with the latest changes from your team or other collaborators. This helps prevent conflicts and keeps everyone working on the most recent version of the code.

    ```bash
    git pull origin main   # Pulls changes from the main branch of the remote repository
    ```

## Putting It All Together

With these five (sorry, six) commands, you can clone a Git repository, track and stage changes, commit them with a message, check the status of your project, and finally push your commits to a remote repository. While Git has a lot more to offer, mastering these basics will give you a solid foundation and change the way you manage your projects.
