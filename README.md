# Project_1
Red Team virtual network with monitoring by ELK stack
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below. 

- Images/ELK_diagram.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  - Ansible/

This document contains the following details:
- Description of the Topologuy
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network.
- The load balancer ensures that web traffic coming in will be shared amongst the three web servers, creating a highly redundant network. 
- The jump box access controls ensure that only authorized users will be able to connect to the network in the first place. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file systems of the VMs on the network and to watch system metrics.
- Filebeat keeps the states of each file on the VMs and detects changes in said files.
- Metricbeat collects metrics on systems from the operating system and from running services

The configuration details of each machine may be found below.

| Name           | Function   | IP Address | Operating System |
|----------------|------------|------------|------------------|
| Jump Box       | Gateway    | 10.0.0.4   | Linux            |
| DVWA 1(Web-1)  | Web Server | 10.0.0.5   | Linux            |
| DVWA 2(Web-2)  | Web Server | 10.0.0.6   | Linux            |
| DVWA 3(Web-3)  | Web Server | 10.0.0.7   | Linux            |
| ELK            | Monitoring | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are _not_ exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 107.129.207.161

Machines within the network can only be accessed by each other over the network. 
- Only the docker ansible container on the jumpbox(10.0.0.4) is allowed to ssh into the ELK VM. 

summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 107.129.207.161      |
| DVWA 1   | No                  | 10.0.0.0/24          |
| DVWA 2   | No                  | 10.0.0.0/24          |
| DVWA 3   | No                  | 10.0.0.0/24          |
| ELK      | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because many different machines can be configured the exact same way if need be in a very fast manner. 

The playbook implements the following tasks:
- Installs docker.io
- Installs pip3
- Installs the Docker python module
- Makes space to use more memory
- Downloads and launches a docker ELK container
- Enables the docker service on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
- Images/docker_ps_output.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
| Name           | Function   | IP Address | Operating System |
|----------------|------------|------------|------------------|
| DVWA 1(Web-1)  | Web Server | 10.0.0.5   | Linux            |
| DVWA 2(Web-2)  | Web Server | 10.0.0.6   | Linux            |
| DVWA 3(Web-3)  | Web Server | 10.0.0.7   | Linux            |


We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat detects changes to the filesystems of the VMs. Filebeat specifically collects Apache logs
- Metricbeat detects changes in system metrics, such as CPU usage. We us it to detect SSH logins, failed sudo escalations and CPU/RAM statistics. 

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook files to the Ansible directory.
- Update the hosts file to include each VM to run each playbook on.
  - example: 
    [webservers]
     10.0.0.5

    [elk]
     10.1.0.4

- Run the playbook, and navigate to host VM to check that the installation worked as expected.
  - ssh into host vm and run: sudo docker ps to make sure elk is running

- Which file is the playbook? Where do you copy it? 
  -The playbook to install the ELK stack from within an ansible container is the install_elk.yml file. You should copy the whole ansible directory to the ansible node

- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on? 
  - You will need to update the ansible/hosts file to make any changes as to which VMs you want to run the playbook on. Make sure the VM is under the [webservers] hosts group 
  - Filebeat will need to be installed directy onto the VM that is being monitored, so you can add the particular VM to the [webservers] hosts group in the hosts file and run the filebeat-playbook.yml file

- _Which URL do you navigate to in order to check that the ELK server is running?
  - You will need to navigate to your specific ELK server public ipaddress on port 5601(kibana runs on this port) and then at (/app/kibana) to the url
  - example: 52.255.187.240:5601/app/kibana
