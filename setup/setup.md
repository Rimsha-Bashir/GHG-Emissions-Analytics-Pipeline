1. Create a project in GCP - `ghg-capstone` 
2. Install Google Cloud SDK.
3. Create service account `ghg-user`. Give the below permissions:
    ![alt text](../images/permissions.png)
4. Create SSH key (if you don't have it yet), add it to GCP. In order to login to the VM. 
5. Enable compute engine API, BigQuery API, IAM API, dataproc api. 
6. Create a vm - ghg-capstone-vm with the below specifications:
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

7. modify/update config file if you already have it setup to add a new Host `ghg-capstone-vm`.
8. Login to your VM locally by running `ssh ghg-capstone-vm`. 
9. Clone this repo using http in the VM. 


10. go to git repo, pull from origin main, 
11. then, chmmod +x setup.sh 
12. run setup.sh bash file... to install all dependencies inside VM>bin/. **Remember to logout then login for some changes to be updated!**


13. Add service account keys to VM (locally) - It's convenient to make sure your json file is saved in a Home dir location.
For example, create .gc in your home dir, add ghg-creds.json there...  then cd to that folder, do sftp ghg-capstone-vm and mkdir .gc, cd .gc then put ghg-creds.json.  (Can I create a setup file for this as well?)

Can also do this - locally. 
rimsh@LAPTOP-J29FGN6B MINGW64 ~
$ scp ~/.gc/ghg-creds.json rimsha@de-zoomcamp:~/.gc/
ghg-creds.json                                                                            100% 2346    72.6KB/s   00:00



