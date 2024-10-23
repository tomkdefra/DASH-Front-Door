---
title: "Basic vocabulary of Version Control"
permalink: /set-up/git-glossary/
---

A non-exhaustive list!

### General Version Control Terms
- **Version Control System (VCS)**: A system that records changes to files over time, enabling you to recall specific versions later. Git is a popular example.
- **Repository (Repo)**: A storage location for your project files and the entire history of changes made to those files. A repository can be local (on your computer) or remote (hosted on a platform like GitHub).
- **Commit**: A snapshot of changes made to the files in your repository. Each commit has a unique ID and usually includes a message describing what was changed.
- **Branch**: A separate line of development in a repository. Branches allow you to work on different features or fixes without affecting the main codebase. The main branch is often called "main" or "master."
- **Merge**: The process of combining changes from one branch into another. This usually happens when a feature or fix developed on a separate branch is ready to be integrated into the main branch.
- **Conflict**: Occurs when changes in different branches clash and Git cannot automatically merge them. Conflicts must be resolved manually by the developer.
- **Pull Request (PR)**: A GitHub feature that allows developers to notify team members about changes made in a branch. It provides a platform for reviewing and discussing code before merging it into the main branch.

### Git CLI Commands
- **`git init`**: Initializes a new Git repository in your current directory.
- **`git clone [URL]`**: Creates a local copy of a remote repository from a given URL.
- **`git status`**: Displays the state of the working directory and staging area, showing which files are modified, untracked, or staged for the next commit.
- **`git add [file]`**: Stages a file or files for the next commit.
- **`git commit -m "[message]"`**: Records the staged changes in the repository with a message describing the changes.
- **`git pull`**: Fetches and merges changes from the remote repository into the current branch.
- **`git push`**: Uploads local commits from your branch to a remote repository.
- **`git branch`**: Lists all branches in the repository, and indicates the current branch.
- **`git checkout [branch-name]`**: Switches to another branch in your repository.
- **`git merge [branch-name]`**: Merges the specified branch into the current branch.

### GitHub-Specific Terms
- **Fork**: A personal copy of another user’s repository. Forking a repository allows you to freely experiment with changes without affecting the original project.
- **Star**: A way to bookmark a repository that you find interesting or want to keep track of. It’s also a form of endorsement for the project.
- **Issue**: A GitHub feature used to track tasks, enhancements, bugs, and other requests related to a project. Issues can be assigned to users, labeled, and linked to pull requests.
- **GitHub Actions**: A CI/CD (Continuous Integration/Continuous Deployment) service provided by GitHub to automate workflows like testing and deployment.
- **Discussion**: A GitHub feature that allows for threaded conversations around specific topics, separate from issues or code review.
- **Projects**: A GitHub feature that provides a Kanban-style board for managing and organising tasks, issues, and pull requests within a repository.
