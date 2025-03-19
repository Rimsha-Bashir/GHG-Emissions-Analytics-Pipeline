1. Create a project in GCP - `ghg-capstone` 
2. Install Google Cloud SDK.
3. Create service account `ghg-user`. Give the below permissions:
    ![alt text](../images/permissions.png)
4. Create SSH key (if you don't have it yet), and add it to GCP. In order to login to the VM.

    (Generate SSH keys to login to VM instances (if you don't have it yet). This will generate a 2048 bit rsa ssh keypair, named gcp and a comment of <username>. The comment (<username>) will be the user on VM :

    In terminal:

    ```bash
    cd ~/.ssh
    ssh-keygen -t rsa -f ~/.ssh/<sshkey_name> -C <username>
    ```

    Copy the generated public key to google cloud: (Compute Engine -> Metadata -> SSH Keys -> Add ssh key) and copy all from file <sshkey_name>.pub. If you already have SSH key to work with your GCP, you can reuse it.)

5. Enable compute engine API, BigQuery API, IAM API, Dataproc API,  Service Networking API. 
6. Create a vm - `ghg-capstone-vm` with the below specifications:
    - Machine Configs: 
        - instance name: `ghg-capstone-vm`
        - region: `europe-west1 (belgium)`
        - machine type: `e2-standard-4 (4 vCPU, 2 core, 16 GB memory)`
    - OS & Storage:
        - OS: `Ubuntu`
        - version: `Ubuntu 20.04 LTS`
        - size: `30GB`
    - Identity & API access:
        - select `scope`-`allow default access` and `firewall`-`allow https traffic`

7. Create a firewall rule to allow access to Kestra UI at port 8080. 

    ![alt text](../images/firewall_rule.png)

    Click on `Create`

7. Modify/update config file if you already have it setup to add a new Host `ghg-capstone-vm`, like this - 
```
    Host ghg-capstone-vm 
        HostName <external-ip>
        User <username> 
        IdentityFile ~/.ssh/<sshkey_name>
```
8. Login to your VM locally by running `ssh ghg-capstone-vm`. 
9. Clone this repo using http in the VM!

10. go to git repo, pull from origin main, 
11. then, chmmod +x setup.sh 
12. run setup.sh bash file... to install all dependencies inside VM>bin/. **Remember to logout then login for some changes to be updated!**


13. Add service account keys to VM (locally) - It's convenient to make sure your json file is saved in a Home dir location.
For example, create `.gc` in your home dir, add `ghg-creds.json` there...  then `cd` to that folder, do `sftp ghg-capstone-vm` and `mkdir .gc`, `cd .gc` then `put ghg-creds.json`.  

Can also do this - locally. 
```bash
rimsh@LAPTOP-J29FGN6B MINGW64 ~
$ scp ~/.gc/ghg-creds.json rimsha@de-zoomcamp:~/.gc/
ghg-creds.json                                                                            100% 2346    72.6KB/s   00:00
```

14. Configure gcloud with your service account .json file (Make sure to add the correct path in the .env file)
```bash
rimsha@de-zoomcamp:~/GHG-Emissions-Analytics-Pipeline$ source .env
rimsha@de-zoomcamp:~/GHG-Emissions-Analytics-Pipeline$ export GOOGLE_APPLICATION_CREDENTIALS=$KEY_FILE_PATH
rimsha@de-zoomcamp:~/GHG-Emissions-Analytics-Pipeline$ gcloud auth activate-service-account --key-file=$KEY_FILE_PATH
Activated service account credentials for: [ghg-user@ghg-capstone.iam.gserviceaccount.com]
```

15. Login to your VM via ssh and go to the terraform dir. Run terraform init, terraform plan and terraform apply. 


16. Running kestra... modify email in .env to a valid email id. 
