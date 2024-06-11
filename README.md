# Web Application Project

## Overview

This project is a web application developed to demonstrate the integration of frontend, backend, and database connectivity. The application is containerized using Docker, deployed using Kubernetes on Google Kubernetes Engine (GKE), and version controlled with GitHub. The frontend is built using HTML, CSS, and JavaScript, while the backend is developed with Python and Flask. The application also connects to a PostgreSQL database.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Deployment](#deployment)
- [Version Control](#version-control)
- [Screenshots](#screenshots)
- [Challenges](#challenges)
- [Contributing](#contributing)
- [License](#license)


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

1. **Push the local repository to Github :** <br><br>
 -> Open Git Bash and loacte the project directory and run following commands to initialize, add and push code to Github repo
   ```sh
   git init
   git add. #add all the files
   git commit -m "commit message of first initilization"
   git remote add origin <github_repo_url> #Connect Github repo from local machine
   git push -u origin main #Push the changes made in code to Github main branch
   

3. **Clone Github repository to Google Source Repository :** <br><br>
-> Open Google Cloud shell and connect the terminal and set configuration to your project
   ```sh
   gcloud config set project [ProjectID] #Config your project id
   git clone <GithubRepo_URL>
   
4. **Create and intialize a container:** <br><br>
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


