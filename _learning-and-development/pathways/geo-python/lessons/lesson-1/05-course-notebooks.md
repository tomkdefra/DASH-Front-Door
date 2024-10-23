---
title: Forking and Cloning a GitHub Repository into Databricks
permalink: /learning-and-development/pathways/geo-python/lessons/lesson-1/course-notebooks/
sidebar:
  - image: assets/images/geopython.png
    image_alt: "Geo-Python logo"
  - nav: "geo-python"
---
 

## Forking the Repository

A **fork** is a personal copy of someone else's repository that lives on your GitHub account. It allows you to freely experiment with changes without affecting the original project.

To fork a repository, use the following process:

1. Click the link below.
2. Fill in the required details for your new repository.
3. Click the "Create fork" button.

[Create a Fork](https://github.com/tomkdefra/geo-python-notebooks/fork){: .btn .btn--primary .btn--large}


## Cloning Your Fork into Databricks

A **clone** is a copy of a repository that you manage on your local machine. Cloning is used to create a local working copy of a remote repository.

1. In your newly forked repository, click on the green [<> Code ](){: .btn .btn--success .btn--small} button.
2. Make sure 'HTTPS' is underlined
3. Copy the URL which will look something like "https://github.com/your-username/geo-python-notebooks.git"

To clone your fork into Databricks, follow these steps:

1. Open your Databricks workspace.
2. Click on the blue [ Create ](){: .btn .btn--info .btn--small} button in the top right.
3. Select "Git Folder".
4. Select "Clone remote Git repo".
5. Enter the URL of your forked repository.
6. Click "Create".

Your forked repository will now be cloned into your Databricks workspace, allowing you to work with the notebooks and other files directly.
