![Image](https://github.com/user-attachments/assets/ab59d62d-af63-4767-aaa2-d51e4c8634b1)

# jenkins-pipeline-deploy-to-eks
# Project Name: End to end deployment of Applications to Kubernetes using a Jenkins CI/CD Pipeline
# Steps for the project

## 1. Create a Keypair that matches your keypair
## 2. Create a Jenkins Server with all the dependencies, libraries and packagies needed.
## 2. Once completed, access the Jenkins server and Set it up
## 4. Run the jenkins-pipeline-deploy-to-eks to create Kubernetes Cluster, create deployments and Services
## 5. Test that the application is running 
## 6. Destroy infrastructure
### project Outlook and Projectory

- provisioing the jenkins-server sitting on an EC2 instance created
- Accessibility to this Ec2 instance through port 8080 defined in SG
- the user me can only have access through SSH connection
- The provioning was done solely using terraform (IAC)

### Workflow for this task using Terraform?

- VPC creation effected to start with

- Internet Gateway created while attaching it the VPC using a Route Table

- Public Subnet creation and associate it with the Route

## MANUAL DEPLOYMENT OF AWS EKS ON MY LOCAL MACHINE

Prerequisite (3 tools that has to be installed)
aws cli

aws --version 

aws-cli/2.23.2 Python/3.12.6 Windows/11 exe/AMD64

terraform --version

Terraform v1.10.5
on windows_amd64

kubectl version

Client Version: v1.30.5

Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3

### Now, let’s see if we have logged it correctly to our cluster:

cd terraform 

### The folder contains the terraform files to deploy jenkins

### now run the following command

terraform init


terraform fmt

terraform validate

terraform apply--auto-approve

# After the terraform approve command, this is the output

![Image](https://github.com/user-attachments/assets/ab57b231-0d4b-4911-a3af-3e536c119915)

# Confirmation of the creation of AWS EKS cluster on AWS infrastructure

![Image](https://github.com/user-attachments/assets/674eb7cd-f821-409e-b9b8-951c81776ec8)


### Now, let’s see if we have logged it correctly to our cluster:

kubectl config current-context

## Command to update kube config

aws eks --region us-east-1 update-kubeconfig --name example

## output of the update

![Image](https://github.com/user-attachments/assets/afd0af45-abab-444b-b311-1a56753cb6c1)

### You can view your cluster’s nodes by running the following command:

kubectl get nodes

NAME                         STATUS   ROLES    AGE   VERSION

ip-10-0-0-60.ec2.internal    Ready    <none>   23m   v1.31.7-eks-473151a

ip-10-0-1-216.ec2.internal   Ready    <none>   23m   v1.31.7-eks-473151a


### To get more specific details about them, you can use the -o custom-columns options:

kubectl get nodes -o custom-columns=Name:.metadata.name,nCPU:.status.capacity.cpu,Memory:.status.capacity.memory


Name                         nCPU   Memory

ip-10-0-0-60.ec2.internal    1      2002836Ki

ip-10-0-1-216.ec2.internal   1      2002836Ki


### With the long command from above, we can view the number of CPUs our nodes have and their available memory.

### Let’s deploy an Nginx instance to see if the cluster is working correctly:

kubectl run --port 80 --image nginx nginx
pod/nginx created

kubectl get pods

NAME    READY   STATUS    RESTARTS   AGE

nginx   1/1     Running   0          18s

kubectl port-forward nginx 3000:80

Forwarding from 127.0.0.1:3000 -> 80

Forwarding from [::1]:3000 -> 80

## This is the final deployment of nginx web server on AWS EKS cluster

![Image](https://github.com/user-attachments/assets/6924c980-fe65-40da-9a37-ee9fd450ac92)



## Creating a yaml file

alias k=kubectl

export do="--dry-run=client -o yaml"

kubectl run --port 80 --image nginx nginx $do > pod.yaml

cat pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}