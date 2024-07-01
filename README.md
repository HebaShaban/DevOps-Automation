## DevOps Automation with Jenkins, Gogs, and Ansible

This project automates the installation of Apache on a target VM using Jenkins, Gogs, and Ansible.

### Infrastructure Setup

**1. Virtual Machines**

Three virtual machines (VMs) are created:

* **Jenkins Installation:**
    * Update the system and install Java.
    * Add Jenkins repository and install Jenkins.
    * Start and enable Jenkins service.
    * Open Jenkins port in the firewall.
* **Gogs Installation:**
    * Install dependencies required by Gogs.
    * Download and configure Gogs server.
    * Open Gogs port in the firewall.
* **User Management:**
    * Create a bash script `CreateUsers.sh` to add users and groups.
    * Create a bash script `NotGroupMembers.sh` to list users not in the `deployG` group.

### Gogs Integration with Jenkins
 
**1. private Gogs repository
guide outlines how to create an access token , enabling secure interaction with external tools like Jenkins for continuous integration and deployment (CI/CD).

1. Generate an Access Token:

   * Log in to your Gogs server as an administrator.
   * Navigate to Settings -> Applications.
   * Click Create New Token.
   * Choose a descriptive name for the token ("Jenkins Integration").
   * click Generate Token
     
**2. Webhook Configuration in Gogs**

* In the Gogs repository settings, navigate to Webhooks.
* open gogs repo setting > webhook > Add webhook > Add jenkins with Gogs-webhook/endpoint

    **3. Git Plugin Installation in Jenkins**

* Install the Git plugin in Jenkins.
* Go to the Jenkins dashboard -> Manage Jenkins -> Manage Plugins.
* Under the Available tab, search for "git plugin" and install it.
* Add a new webhook with the URL: `http://<Jenkins_Server_IP>:8080/gogs-webhook/endpoint`



### Git Repository on Gogs

A Git repository named "InstallApache" is created on Gogs containing the following files:

* InstallApache.yml: Ansible playbook to install Apache on the target VM.
* NotGroupMembers.sh: Bash script to list users not in the `deployG` group (from User Management VM).
* Jenkinsfile: Script defining the Jenkins pipeline stages.
* createUser.sh: Bash script to add users and groups (from User Management VM).
* Inventory: Ansible inventory file defining the target VM.

**Note:** Due to security concerns, including images directly in a README file is not recommended. 

### Pipeline Creation

**1. Jenkins Credential Setup**

* Access Jenkins dashboard -> Manage Jenkins -> Credentials.
* Under Global credentials, add a username and password credential.

**2. Pipeline Definition**

* In the Jenkins dashboard, create a new item.
* Choose "Pipeline" and provide a name for the pipeline (InstallApache).
* Select "Pipeline definition" as "Script from SCM".
* Choose "git" as the SCM type.
* Provide the Git repository URL for "InstallApache" on Gogs.
* Add the Jenkins credential created earlier.
* Set the script path to "Jenkinsfile" within the repository.
* Enable the build trigger option "Build when a change is pushed to the Gogs repository" to automate the pipeline execution on code updates.

### Apache Installation

The pipeline utilizes an Ansible playbook (`InstallApache.yml`) to install Apache on the target VM3. The playbook leverages another file (`Inventory`) that defines the target VM's hostname or IP address and secert.

### Email Notifications

Explain how to configure email notifications in Jenkins.
Steps:

* Go to the Jenkins dashboard.
* Navigate to Manage Jenkins > System Configuration.
* Scroll down to "Extended E-mail Notification."
* Enter the SMTP server details:
* SMTP server: smtp.gmail.com
* SMTP port: 465
* Under "Advanced," add credentials (username/password) created using Google App Passwords.
* Select "Use SSL" and save the configuration.

### Email Notifications with Email Extension Plugin

* Install the Email Extension Plugin:

  * Go to the Jenkins dashboard.
  * Navigate to Manage Jenkins > Manage Plugins.
  * Under the Available tab, search for the Email Extension plugin.
  * Install the Email Extension plugin.

This README provides a comprehensive overview of the project's functionalities. Refer to the respective scripts (bash and Ansible) for detailed implementation steps.
