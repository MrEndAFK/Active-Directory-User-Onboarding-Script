# Simple Active Directory User Onboarding Script

A PowerShell script to automate creating user accounts in Active Directory (AD), adding them to appropriate groups, and logging actions for auditing. Ideal for helpdesk environments to streamline user onboarding.

# Features

**🧑‍💻 User Creation**: Automates creating new AD users with attributes like username, department, and email.

**🛡️ Group Membership (Optional)**: Automatically assigns users to a department-specific AD group (if it exists).

**📜 Action Logging**: Logs all performed actions (e.g., user creation, group addition) for auditing purposes.

# Prerequisites
✅ Active Directory module installed in PowerShell.

🔑 Administrative privileges to manage AD users and groups.

⚡ PowerShell version 5.1 or later.

# How to Use
**1️⃣ Clone/Download the Script**

Clone the repository or download the script to your local machine:

    ```
    git clone https://github.com/MrEndAFK/Active-Directory-User-Onboarding-Script.git
    ```

**2️⃣ Run the Script**
Open PowerShell with administrative privileges, navigate to the script location, and execute:

    ```
    .\UserOnboardingScript.ps1
    ```

**3️⃣ Provide Input**
The script will prompt you to enter:

*First Name: (e.g., John)*

*Last Name: (e.g., Doe)*

*Department: (Optional, for assigning group membership)*

**4️⃣ Check Results**
-Success messages will be displayed in the console.
-Errors (if any) will also be displayed.
-Logs will be saved to C:\UserCreationLogs\log.txt.
Example Output:

    ```
    Enter First Name: John  
    Enter Last Name: Doe  
    Enter Department: IT
    User john.doe created successfully in department IT  
    Added john.doe to IT-Group  
    Logged actions to C:\UserCreationLogs\log.txt  
    ```

**Optional Features**
Group Membership: Automatically adds users to groups like IT-Group or HR-Group based on department.

Logging: Every action is logged with details like username, department, and timestamp.

**Log File Details**
Logs are saved at:
    ```
    C:\UserCreationLogs\log.txt
    ```
Example
    ```
    john.doe | IT | 2024-12-01 14:35:22
    ```

# Simple but works! 
# I am working on a small GUI with user input fields using PowerShell  Forms, so non-techies can run it easily.