1. Create a project in GCP - `ghg-capstone` 
2. Install Google Cloud SDK.
3. Create service account `ghg-user`. Give the below permissions:
    ![alt text](../images/permissions.png)
4. Create SSH key (if you don't have it yet), add it to GCP. In order to login to the VM. 
5. Enable compute engine API, BigQuery API, IAM API. 
6. Create a vm - ghg-capstone-vm with the below specifications:
    - Machine Configs: 
        - instance name: `ghg-capstone-vm`
        - region: `europe-west1 (belgium)`
        - machine type: `e2-standard-4 (4 vCPU, 2 core, 16 GB memory)`
    - OS & Storage:
        - OS: `Ubuntu`
        - version: `Ubuntu 20.04 LTS`
        - size: `30GB`

7. modify/update config file if you already have it setup to add a new Host `ghg-capstone-vm`.
8. Login to your VM locally by running `ssh ghg-capstone-vm`. 
9. Clone this repo using http in the VM. 


10. mkdir bin and run setup.sh bash file... to install all  dependencies inside VM>bin/ 

