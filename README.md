# Web Application Project

## Overview

This project is a web application developed to demonstrate the integration of frontend, backend, and database connectivity. The application is containerized using Docker, deployed using Kubernetes on Google Kubernetes Engine (GKE), and version controlled with GitHub. The frontend is built using HTML, CSS, and JavaScript, while the backend is developed with Python and Flask. The application also connects to a PostgreSQL database.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Deployment](#deployment)
- [Database Connection](#database-connection)
- [Troubleshooting](#troubleshooting)


## Features

- **Frontend:**
  - HTML form to capture two values.
  - JavaScript for form submission and validation.
  - CSS for responsive styling.
  
- **Backend:**
  - Python Flask application to handle form data.
  - PostgreSQL database connectivity.
  - Error handling and logging.

- **Deployment:**
  - Docker containers for frontend and backend.
  - Kubernetes configurations for deployment on GKE.
  - Load balancer configuration.
  - Basic monitoring and logging setup.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Python](https://www.python.org/)
- [Docker](https://www.docker.com/)
- [Kubernetes](https://kubernetes.io/)
- [Google Cloud SDK](https://cloud.google.com/sdk)

### Setup

1. **Develop FrontEnd of Webapp:** <br><br>
-> Create the HTML file (index.html)to capture the data. <br>
-> Create Javascript file (script.js) <br>
-> Enhance the webpage usign style sheets (styles.css) <br>

2. **Develop Backend application :** <br><br>
-> Create the python application (app.py) to connect frontend to capture the data from frontend and load to database. <br>
-> Create requirements.txt to install pre-requisite libraries <br>
   Flask <br>
   Flask-SQLAlchemy <br>
   psycopg2-binary <br>
   flask_cors <br>
-> Run the file in local machine
   ```sh
    python app.py
  
3. **Push the local repository to Github :** <br><br>
 -> Open Git Bash and loacte the project directory and run following commands to initialize, add and push code to Github repo
   ```sh
   git init
   git add. #add all the files
   git commit -m "commit message of first initilization"
   git remote add origin <github_repo_url> #Connect Github repo from local machine
   git push -u origin main #Push the changes made in code to Github main branch
   

4. **Clone Github repository to Google Source Repository :** <br><br>
-> Open Google Cloud shell and connect the terminal and set configuration to your project
   ```sh
   gcloud config set project [ProjectID] #Config your project id
   git clone <GithubRepo_URL>
   
5. **Create and intialize a container:** <br><br>
-> Enable Required APIs: Enable the *Google Kubernetes Engine (GKE)* API. <br>
-> Create a Cluster. <br>
-> Configure kubectl to use GKE Cluster <br>
   
   ```sh
   gcloud services enable container.googleapis.com
   ```

    ```bash
     gcloud container clusters [CLUSTER_NAME] \
      --zone [ZONE] \
      --num-nodes [NUM of NODES] \
      --machine-type e2-medium \
      --disk-size 10GB
    ```

    ```bash
     gcloud container clusters get-credentials [CLUSTER_NAME] --zone [ZONE]
    ```

## Deployment

1. **Push the image to Artifact Registry using Docker:** <br><br>
-> Build the docker image for both frontend and backend. <br>
-> Push the docker image for both frontend and backend. <br>
   ```bash
   docker build -t gcr.io/[Project-ID]/[Tag-Name]:latest .
   ```
   ```bash
   docker push gcr.io/[Project-ID]/[Tag-Name]:latest .
   ``` 
2. **Deploy configuration file:** <br><br>
-> Create and apply a deployment configuration file for both frontend and backend. <br>
-> Create and apply a service configuration file for both frontend and backend. <br>
   ```bash
   kubectl apply -f <Deployment-File> # Deployment YAML file for backend and frontend
   ```
   ```bash
   kubectl apply -f <Service-File> #Service YAML file for backend and frontend
   ```
3. **Verify Deployment Status:** <br><br>
-> Check the status of your deployment and services with the commands. <br>
    ```bash
     kubectl get deployments
     kubectl get pods
     kubectl get services
     ```

## Database Connection

1. **Connect PostgreSQL with application:** <br><br>
-> Prerequisite - Verify the python application app.py backend in configured with PostgreSQL database credentials correctly. <br>

2. **Collect Form Data:** <br><br>
-> The backend Flask application will handle POST requests to collect data from the frontend form and insert it into the PostgreSQL database. <br>
-> Once you have External IP address , update the javascript file and append the External IP or DNS to trigger the fetch function.<br>
-> Delete the deployment file for both backend and frontend and reapply the kubectl deployment file. <br>
-> Run the PSql command to connect database via gcloud shell: <br> 
      ```bash
       psql -h [Database-HostIP] -U postgres -d postgres #Enter the public IP of PostgreSQL database
       
 -> This will prompt to enter database password -- Enter Database password <br>
 -> Check the database by running this command. <br>
      Select  * from [Schema][Name]; # Enter the schema i.e name of schema where table resides and Name is the database table name
    
## Troubleshooting

1. **Curl Command:** <br><br>
-> This command sends a POST request to the URL http://[namespace].default.svc.cluster.local:5000/submit with a JSON payload.
   ```bash
       curl -X POST http://[ExternalIP / DNS]:[targetPort]/submit -H "Content-Type: application/json" -d '{"value1": "test1", "value2": "test2"}'
2. **Pod Deployment error:** <br><br>
-> To check the ImagePullOFF / CrashbackOFF error verify the pods using kubectl command. <br>
```bash
       kubectl logs -f [pod-name]
       kubectl exec -it [pod-name] -- /bin/bash
       kubectl decribe pods [pod-name]
       kubectl exec -it [pod-name] -- nslookup [ExternalIP]
