---
title: "Git Configuration"
permalink: /set-up/git-config/
---

## Generating and Adding an SSH Key to GitHub Using Git Bash

This guide provides step-by-step instructions to open Git Bash, see the contents of a directory, generate an SSH key, and add it to GitHub.

### Step 1: Open Git Bash
1. **Click on the Start Menu**:
    - Click on the Windows icon in the bottom-left corner of your screen. Remember that if you're using the AVD, pressing the Windows key on your keyboard will open the search on your laptop, not on the AVD!
2. **Search for Git Bash**:
    - Type "git" in the search bar. You should see "Git Bash" appear in the search results.
3. **Open Git Bash**:
    - Click on "Git Bash" to open the terminal.

        ![Open Git Bash]({{ "/assets/images/Screenshot_2024-07-16_142557.jpg" | relative_url }})

        ![Verify Directory]({{ "/assets/images/Screenshot_2024-07-19_134937.jpg" | relative_url }})
 
### Step 2: Verify Your Current Directory
1. **Check your current directory**:
    - Type `pwd` in the terminal and press Enter. This command displays the current directory path.
    
    - Type `ls -a` in the terminal and press Enter. This command lists the contents of the current directory, and the '-a' (all) flag ensures hidden files and folders are also listed. 
    
    We will come back to this later.

    ![Add SSH Key to Agent]({{ "/assets/images/Screenshot_2024-07-16_142904.jpg" | relative_url }})

### Step 3: Generate a New SSH Key

The following instructions are taken from the GitHub Documentation. 
1. **Generate the SSH key**:
    - Type `ssh-keygen -t ed25519 -C "your_email@example.com"` and press Enter.
    - Replace `your_email@example.com` with your GitHub email address.

2. **Follow the prompts**:
    - Press Enter to accept the default file location.
    - When prompted, you can add a passphrase for added security or press Enter to skip.

### Step 4: Copy the SSH Key
1. **Copy the SSH key to your clipboard**:
    - If you `ls -a` again, you will see that a new hidden folder called `.ssh/` has been created to hold your SSH keys.
    - Type `ls .ssh/` and press enter. You will see the two files: `id_ed25519` is your private key and should stay here on your computer, safe and out of sight! `id_25519.pub` is your public key. The contents of this is what you will now copy and add to your GitHub. 
    - Type `clip < ~/.ssh/id_ed25519.pub` and press Enter. This command copies the SSH key to your clipboard.

    ![Copy SSH Key]({{ "/assets/images/Screenshot_2024-07-16_172705.jpg" | relative_url }})

### Step 5: Add SSH Key to GitHub
1. **Open GitHub and go to Settings**:
    - Log in to your GitHub account.
    - Click on your profile picture in the top-right corner and select "Settings".
    
    ![GitHub Settings]({{ "/assets/images/Screenshot_2024-07-19_142131.jpg" | relative_url }})

2. **Navigate to SSH and GPG Keys**:
    - In the left sidebar, click on "SSH and GPG keys".

    ![SSH and GPG Keys]({{ "/assets/images/Screenshot_2024-07-19_142221.jpg" | relative_url }})

3. **Add a new SSH key**:
    - Click on the "New SSH key" button.
    - In the "Title" field, enter a descriptive name for the new key (e.g., "AVD_key").
    - Paste your SSH key into the "Key" field by pressing Ctrl + V or right-clicking and selecting "Paste".
    - Click the "Add SSH key" button to save the new key.

    ![Add New SSH Key]({{ "/assets/images/Screenshot_2024-07-19_142449.jpg" | relative_url }})

### Step 6: Verify the Connection
1. **Test your SSH connection**:
    - Type `ssh -T git@github.com` in Git Bash and press Enter.
    - If this is your first time connecting, you may be asked to confirm the connection. Type "yes" and press Enter.
    - If successful, you should see a message like "Hi username! You've successfully authenticated, but GitHub does not provide shell access."

You have now successfully generated an SSH key and added it to your GitHub. You can now communicate securely with your GitHub repositories without having to enter your username and personal access token at every command.
