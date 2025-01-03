# ULE_DevSecOps_my_flask_app - Lab 1: "CI/CD with Docker" 

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation and Setup](#installation-and-setup)
4. [Step 1: Creating an Application](#step-1-creating-an-application)
5. [Step 2: Creating a Dockerfile](#step-2-creating-a-dockerfile)
6. [Step 3: (Optional) Creating a Docker Compose File for Local Testing](#step-3-optional-creating-a-docker-compose-file-for-local-testing)
7. [Step 4: Configuring GitHub Actions](#step-4-configuring-github-actions)
8. [Step 5: Testing the CI/CD Pipeline](#step-5-testing-the-cicd-pipeline)
9. [Conclusion](#conclusion)
10. [License](#license)

## Introduction

This project is focused on setting up a DevOps pipeline for a simple Flask web application. The main objectives are to create and containerize the application, set up local testing with Docker Compose, and configure a CI/CD pipeline using GitHub Actions. Through this project, we aim to automate the build, test, and deployment processes, ensuring a streamlined and efficient development and release cycle.

## Prerequisites

- A Windows 64-bit computer connected to the internet.
- A code editor (like Notepad++ or Visual Studio Code).
- Docker Desktop: [Docker Desktop Download](https://www.docker.com/products/docker-desktop).

## Installation and Setup

### 1. GitHub Account and Repository

- Navigate to [GitHub](https://github.com/).
- Sign in to your GitHub account or register for a new one using your email.
- Create a new repository named `ULE_DevSecOps_my_flask_app`:
  - Set it to Public
  - Add a README file
  - Add a `.gitignore` template: Python
  - License: None
- Click on **Commit Changes** to save the README.

### 2. Install Git for Windows

- Navigate to [Git SCM](https://git-scm.com/).
- Download Git for Windows Setup (64-bit).
- Install Git, selecting the default options, except choosing "Use Windows' default console window" instead of "Use MinTTY (the default terminal)."
- Verify the installation in Windows PowerShell:
  ```powershell
  git --version
  ```
  Expected output: ```git version 2.47.1.windows.1```

- Add Git to the system PATH:
  - In Windows File Explorer, right-click on `Este Equipo`.
  - Click on `Propiedades > Configuración Avanzada del Sistema > Opciones avanzadas > Variables de entorno > Variables del sistema: Path > Editar > Editar variable de entorno > Nuevo`.
  - Add this two environment variables:
    ```plaintext
    C:\Program Files\Git\cmd
    ```
    ```plaintext
    C:\Program Files\Git\bin
    ```
  - Click on `Aceptar`, `Aceptar`, `Aceptar` to save the changes.

### 3. **Clone the Repository:**
   - In Windows PowerShell, clone your `ULE_DevSecOps_my_flask_app` GitHub repository to create a local copy:
     ```powershell
     cd "[ruta del directorio de mi ordenador en el que voy a almacenar la copia del repo]"
     ```
     ```powershell
     git clone https://github.com/[your-GitHub-username]/ULE_DevSecOps_my_flask_app.git
     ```
     ```powershell
     cd ULE_DevSecOps_my_flask_app
     ```

### 4. **Configure Git Identity:**
   - In Windows PowerShell, set up your Git identity locally so changes apply only to this specific repository and commits are attributed to you:
     ```powershell
     git config user.email "[your-email]"
     ```
     ```powershell
     git config user.name "[your-github-username]"
     ```
---

## Step 1: Creating an Application

### Creating the Flask Web Application

1. **Create `app.py` in Notepad++:**
   - In Notepad++, type the following Python code:
     ```python
     from flask import Flask

     app = Flask(__name__)
      
     @app.route('/')
     def hello_world():
         return 'Hello, CI/CD with Docker!'
      
     if __name__ == '__main__':
         app.run(host='0.0.0.0', port=5000)
     ```
   - Save the file as `app.py` in the `ULE_DevSecOps_my_flask_app` directory that you previously created on your computer.

### Staging, Committing, and Pushing the Changes of the Flask Web Application

1. **Stage the Changes:**
   - In Windows PowerShell, stage the changes using the `git add` command to include the `app.py` file in the next commit:
     ```powershell
     git add app.py
     ```

2. **Commit the Changes:**
   - In Windows PowerShell, commit the changes using the `git commit` command to create a history log in the repository:
     ```powershell
     git commit -m "Add Flask web application"
     ```

3. **Push the Changes:**
   - In Windows PowerShell, push the changes using the `git push` command to send the changes to the main branch:
     ```powershell
     git push origin main
     ```
### Authorizing Git Credential Manager

1. **Authorize Git Credential Manager:**
   - When prompted in the browser, authorize the Git Credential Manager through the Git-Ecosystem.

### Summary for Step 1

In the **Dev** part of DevOps, there are four main phases: **Plan**, **Code**, **Build**, and **Test**. In this step, we planned to create a Flask web application and set up a CI/CD pipeline.

We coded the Flask web application by creating the `app.py` file and began the building process. Specifically, we focused on the **Code** phase of the DevOps lifecycle: the `app.py` Flask web application was coded and the file was created.

We then added the `app.py` file to our repository using the `git add`, `git commit`, and `git push` commands, successfully integrating the code into version control (which is part of the continuous integration (CI) process). The full CI/CD pipeline setup and automation (which involves more steps, such as automated testing and deployment) will be addressed in a later step (Step 4).

---

## Step 2: Creating a Dockerfile

A Dockerfile is a special file that contains a set of instructions to define how to build a Docker image (a snapshot of an application and its dependencies).

### Creating the Docker Image

A Docker image is a lightweight, standalone, and executable software package that includes everything needed to run a piece of software, including the code, runtime, libraries, and dependencies. 

1. **Create `Dockerfile` in Notepad++:**
   - In Notepad++, write down the following instructions:
     ```dockerfile
     # Use an official Python runtime as a parent image
     FROM python:3.8-slim

     # Set the working directory in the container
     WORKDIR /app

     # Copy the current directory contents into the container at /app
     COPY app.py /app/

     # Install any needed libraries and packages in the container
     RUN pip install flask

     # Make port 5000 for the app available to the world outside the container
     EXPOSE 5000

     # Run app.py when the container starts
     CMD ["python", "app.py"]
     ```
   - Save the file as `Dockerfile` (without extension) in the `ULE_DevSecOps_my_flask_app` directory on your computer.

2. **Verify the `Dockerfile` was properly created and saved:**
   - In PowerShell, list the files in the working directory to ensure the `Dockerfile` is there and has no extension:
     ```powershell
     dir
     ```
     Expected output: ```Directorio: C:\Users \[...]\ULE_DevSecOps_my_flask_app```
     ```plaintext
     Mode                 LastWriteTime         Length Name
     ----                 -------------         ------ ----
     -a----        02/01/2025     13:46           3586 .gitignore
     -a----        02/01/2025     14:33            200 app.py
     -a----        02/01/2025     15:59            490 Dockerfile
     -a----        02/01/2025     13:46            313 README.md
     ```

### Building the Docker Image

While creating refers to writing the instructions in the `Dockerfile`, building refers to executing those instructions to produce a Docker image.

1. **Open Docker Desktop:**
   - Ensure Docker Desktop is running on your computer.

2. **Build the Docker Image:**
   - In PowerShell, build the Docker image, tagging it (`-t`) with the name "flask_app" and specifying the current directory (.) as the build context:
     ```powershell
     docker build -t flask_app .
     ```
     Expected output: ``` [+] Building 11.7s (9/9) FINISHED docker:desktop-linux```

The result is a portable Docker image that contains everything needed to run your application. This image can then be used to create Docker containers.

### Running the Docker Container

A Docker container is a runnable instance of a Docker image. Containers are isolated from each other and from the host system.

1. **Run the Docker Container:**
   - In PowerShell, run a Docker container from the created image, mapping the port 5000 on your machine to port 5000 in the container:
     ```powershell
     docker run -p 5000:5000 flask_app
     ```

### Accessing the Application

1. **Access the Application:**
   - Navigate to `http://localhost:5000` in your web browser.
     Expected output: ```message: "Hello, CI/CD with Docker!" ```

The Flask development server is running, serving the Flask application to handle web requests.

### Summary for Step 2

The **Dev** part of DevOps consists of **Plan**, **Code**, **Build**, and **Test**, while the **Ops** part includes **Release**, **Deploy**, **Operate**, and **Monitor**. In this step, we focused on building and containerizing the Flask web application, thus covering the **Build** and **Release** phases of the DevOps lifecycle.

We created a Dockerfile to define the instructions for building a Docker image of the web application and then built the Docker image. After that, we ran a Docker container using the created image, effectively moving towards the **Release** phase by running the containerized application.

Thus, we continued the process of setting up the Continuous Integration (CI) part of the CI/CD pipeline by containerizing the application (which makes it portable and easier to deploy across different environments). Continuous Delivery and Continuous Deployment (CD) involve additional steps like automated testing and deployment, which will be addressed in a later step ((Step 4)) as part of the full CI/CD pipeline setup and automation.

---

## Step 3: (Optional) Creating a Docker Compose File for Local Testing

Docker Compose is a tool for defining and running multi-container Docker applications, allowing you to manage multiple Docker containers easily. It uses the `docker-compose.yml` file to specify the configuration of your application’s services, networks, and volumes, and enables you to run them collectively with a single command. Docker Compose is particularly useful for local testing, as it allows you to simulate a production-like environment on your local machine.

Unlike building a Docker image or running a Docker container, Docker Compose orchestrates the entire setup by defining all your services, networks, and volumes in a single `docker-compose.yml file`. This means that while you still need a Dockerfile to build individual images, Docker Compose handles the overall configuration and management of these images and their containers. It is especially useful for applications that consist of multiple components (e.g., a web server, a database, etc.) and need to be tested together.

### Creating the Docker Compose File

1. **Create `docker-compose.yml` in Notepad++:**
   - In Notepad++, create a new file named `docker-compose.yml` with the following content:
     ```yaml
     version: '3.9' # Specifies the version of Docker Compose to use

     services:
       flask:
         image: myapp:latest # Specifies the name and tag of the Docker image to use (myapp:latest)
         build: .            # Tells Docker to build the image using the Dockerfile in the current directory
         ports:
           - "5000:5000"     # Maps port 5000 on your computer to port 5000 in the container
     ```
   - Save the file in the `ULE_DevSecOps_my_flask_app` directory on your computer.

### Running Docker Compose

1. **Stop any running containers:**
   - In PowerShell, stop any running Docker containers from the previous steps:
     ```powershell
     Ctrl+C
     ```

2. **Run Docker Compose:**
   - In PowerShell, navigate to the directory where you cloned your repository and run Docker Compose to start the services defined in the `docker-compose.yml` file:
     ```powershell
     docker compose up
     ```

3. **Verify Docker Compose Execution:**
   - Check if everything is running smoothly. If it is, you can close the PowerShell window.

### Installing Python

1. **Download and Install Python:**
   - Navigate to [Python Downloads](https://www.python.org/downloads/) to download the latest version of Python for Windows Installer 64-bit (e.g., version 3.13.1).
   - Follow the installation steps in the Python Installer.

2. **Set Python Environment Variables:**
   - In Windows File Explorer, right-click on `Este Equipo` and navigate to `Propiedades > Configuración Avanzada del Sistema > Opciones avanzadas > Variables de entorno > Variables del sistema: Path > Editar > Editar variable de entorno > Nuevo`. 
    ```plaintext
    C:\Users\Usuario\AppData\Local\Programs\Python\Python313
    ```
    ```plaintext
    C:\Users\Usuario\AppData\Local\Programs\Python\Python313\Scripts
    ```
  - Click on `Aceptar`, `Aceptar`, `Aceptar` to save the changes.

3. **Verify Python Installation:**
   - In PowerShell, verify the Python installation:
     ```powershell
     python --version
     ```
     Expected output: ```Python 3.13.1```

### Installing Flask

1. **Install Flask:**
   - In PowerShell, install Flask and its dependencies:
     ```powershell
     pip install flask
     ```
     ```powershell
     pip list
     ```
     Expected output:
     ```plaintext
     Package      Version
     ------------ -------
     blinker      1.9.0
     click        8.1.8
     colorama     0.4.6
     Flask        3.1.0
     itsdangerous 2.2.0
     Jinja2       3.1.5
     MarkupSafe   3.0.2
     pip          24.3.1
     Werkzeug     3.1.3
     ```

2. **Verify Flask Application:**
   - In PowerShell, run the Flask application:
     ```powershell
     python app.py
     ```
   - Expected output:
     ```plaintext
     * Serving Flask app 'app'
     * Debug mode: off
     WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
     * Running on all addresses (0.0.0.0)
     * Running on http://127.0.0.1:5000
     * Running on [your local network IP address]
     ```

3. **Test the Flask Application:**
   - Open a new PowerShell window and test the Flask application:
     ```powershell
     curl http://localhost:5000
     ```
   - Expected output: ```Content: Hello, CI/CD with Docker!```

### Modifying the Application and Rebuilding the Docker Compose File

1. **Modify `app.py`:**
   - In Notepad++, modify the code in `app.py` to display the current date by typing the following Python code:
     ```python
     from flask import Flask
     from datetime import datetime

     app = Flask(__name__)
      
     @app.route('/')
     def hello_world():
         current_date = datetime.now().strftime("%Y-%m-%d")
         return f"Hello, CI/CD with Docker! Date: {current_date}"
      
     if __name__ == '__main__':
         app.run(host='0.0.0.0', port=5000)
     ```
   - Save the file.

2. **Rebuild Docker Compose:**
   - In PowerShell, navigate to the directory where you cloned your repository and rebuild the Docker Compose image:
     ```powershell
     docker compose up --build -d
     ```
   - Expected output: ```Container ule_devsecops_my_flask_app-flask-1 Started```

3. **List Docker Containers:**
   - In PowerShell, list all created containers:
     ```powershell
     docker ps -a
     ```

4. **Verify Updated Flask Application:**
   - Test the updated Flask application:
     ```powershell
     curl http://localhost:5000
     ```
   - Expected output: ```Content: Hello, CI/CD with Docker! Date: 2025-01-03```

### Sumary for Step 3

The **Dev** part of DevOps comprises **Plan**, **Code**, **Build**, and **Test**, while the **Ops** part includes **Release**, **Deploy**, **Operate**, and **Monitor**. In this optional step, we focused on creating a Docker Compose file for testing the application in a local environment, which primarily falls under the **Test** phase of the DevOps lifecycle.

We created a `docker-compose.yml` file to define the configuration for our multi-container Docker application and then ran Docker Compose to manage the containers collectively. This allowed us to test the application in an environment that simulates production conditions on our local machine.

We also ensured that our application can be tested locally, as a part ofthe Continuous Integration (CI) process in the CI/CD pipeline. Continuous Delivery and Continuous Deployment (CD) involve additional steps like automated testing and deployment, which will be addressed in the next step as part of the full CI/CD pipeline setup and automation.

---

## Step 4: Configuring GitHub Actions

GitHub Actions allows you to automate, customize, and execute your software development workflows directly in your GitHub repository. In this step, we will configure GitHub Actions to create a CI/CD pipeline.

### Setting Up GitHub Actions

1. **Create the `.github/workflows` directory:**
   - In PowerShell, navigate to the directory where you cloned your repository and create a directory named `.github/workflows` to contain the configuration files for GitHub Actions workflows:
     ```powershell
     mkdir -p .github/workflows
     ```
   - Verify the creation of the `workflows` directory inside `.github`:
     ```powershell
     dir .github
     ```
     Expected output:
     ```plaintext
     Mode                 LastWriteTime         Length Name
     ----                 -------------         ------ ----
     d-----        02/01/2025     21:00                workflows
     ```

2. **Navigate to the `workflows` directory:**
   - In PowerShell, navigate to the `.github/workflows` directory:
     ```powershell
     cd .github/workflows
     ```

### Creating the CI/CD Workflow File

1. **Create `ci-cd.yml` in Notepad++:**
   - In Notepad++, create a new file named `ci-cd.yml` with the following content:
     ```yaml
     name: CI/CD Pipeline # Name of the GitHub Actions workflow

     on:
       push: # Trigger the workflow on push events
         branches:
           - main # Only trigger on push events to the main branch

     jobs: # Define the jobs in the workflow
       build:
         runs-on: ubuntu-latest # Run the job on the latest version of Ubuntu

         steps: # Define the sequence of tasks to execute in the job
           - name: Checkout repository # Step to clone the repository
             uses: actions/checkout@v3                 # GitHub Action to clone the repository

           - name: Set up Docker Buildx # Step to set up Docker Buildx
             uses: docker/setup-buildx-action@v2       # GitHub Action to set up Docker Buildx

           - name: Build Docker image # Step to build the Docker image
             run: docker build -t flask-app .          # Shell command to build a Docker image named "flask-app"

           - name: Run Docker container # Step to run the Docker container
             run: docker run -d -p 5000:5000 flask-app # Shell command to run the container in detached mode and map port 5000

           - name: Add a delay before testing # Step to add a delay to ensure the container is fully started
             run: sleep 30s                            # Shell command to wait for 30 seconds

           - name: Test application # Step to test the application
             run: curl http://localhost:5000           # Shell command to test the application using curl
     ```
   - Save the file in the `.github/workflows` directory on your computer.

2. **Verify the `ci-cd.yml` file:**
   - In PowerShell, verify that the `ci-cd.yml` file has been created in the `.github/workflows` directory:
     ```powershell
     ls
     ```
     Expected output:
     ```plaintext
     Mode                 LastWriteTime         Length Name
     ----                 -------------         ------ ----
     -a----        02/01/2025     21:11            509 ci-cd.yml
     ```

### Summary for Step 4

The **Dev** part of DevOps encompasses **Plan**, **Code**, **Build**, and **Test**, while the **Ops** part includes **Release**, **Deploy**, **Operate**, and **Monitor**. In this step, we focused on configuring GitHub Actions to automate our CI/CD pipeline, covering the **Build**, **Test**, **Release**, and **Deploy** phases of the DevOps lifecycle.
- **Build**: By defining a step to build the Docker image using the `docker build` command.
- **Test**: By defining steps to run the Docker container and test the application using the `curl` command.
- **Release**: By automating the creation of a Docker container that can be deployed.
- **Deploy**: By running the Docker container to deploy the application.

We created a `.github/workflows` directory and set up a `ci-cd.yml` file, defining a workflow that automates the building, testing, and deploying of our application. This workflow is triggered whenever code is pushed to the main branch, ensuring continuous integration and deployment.

By configuring GitHub Actions, we have established a CI/CD pipeline that automatically builds, tests, and deploys our application with each push to the main branch. This setup achieves Continuous Integration by automatically building and testing our code changes, Continuous Delivery by ensuring the application is ready for release, and Continuous Deployment by automating the deployment process. This automation facilitates a consistent and reliable deployment process, reducing the risk of errors and enhancing the efficiency of our development and operations (DevOps) workflow.

---

## Step 5: Testing the CI/CD Pipeline

In this step, we will test the CI/CD pipeline we configured in Step 4 to ensure it works correctly. Testing the CI/CD pipeline involves pushing changes to the repository and verifying that the GitHub Actions workflow is triggered, builds the Docker image, runs the container, and tests the application.

### Testing the Pipeline

1. **Navigate to the root directory of your project:**
   - In PowerShell, navigate back to the root directory of your project:
     ```powershell
     cd ../..
     ```
   - Verify that you are in your cloned repository:
     ```powershell
     ls
     ```
     Expected output:
     ```plaintext
     Mode                 LastWriteTime         Length Name
     ----                 -------------         ------ ----
     d-----        02/01/2025     21:00                .github
     -a----        02/01/2025     13:46           3586 .gitignore
     -a----        02/01/2025     20:04            862 app.py
     -a----        02/01/2025     18:22            109 docker-compose.yml
     -a----        02/01/2025     15:59            490 Dockerfile
     -a----        02/01/2025     13:46            313 README.md
     ```

2. **Prepare the changes for the `ci-cd.yml` file:**
   - Add the changes to the staging area:
     ```powershell
     git add .github/workflows/ci-cd.yml
     ```

3. **Commit the changes:**
   - Commit the changes with a descriptive message:
     ```powershell
     git commit -m "Add CI/CD pipeline configuration"
     ```
     Expected output:
     ```plaintext
     [main 1b57c7c] Add CI/CD pipeline configuration
      1 file changed, 26 insertions(+)
      create mode 100644 .github/workflows/ci-cd.yml
     ```

4. **Push the changes to the main branch:**
   - Push the changes to the `main` branch of your GitHub repository:
     ```powershell
     git push origin main
     ```
     Expected output:
     ```plaintext
     Enumerating objects: 6, done.
     Counting objects: 100% (6/6), done.
     Delta compression using up to 8 threads
     Compressing objects: 100% (3/3), done.
     Writing objects: 100% (5/5), 693 bytes | 693.00 KiB/s, done.
     Total 5 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
     To https://github.com/vmartf05/ULE_DevSecOps_my_flask_app.git
        56db1f7..1b57c7c  main -> main
     ```

5. **Verify the workflow execution on GitHub:**
   - Open your GitHub repository in a web browser.
   - Go to the "Actions" tab to see the workflow execution.
   - If there are errors, address them accordingly.

6. **Update the `ci-cd.yml` file if necessary:**
   - If you encounter an error related to the Dockerfile (e.g., `no such file or directory Error: Process completed with exit code 1.`), ensure it is correctly configured by updating the `ci-cd.yml` file as follows:
     ```yaml
     name: CI/CD Pipeline # Name of the GitHub Actions workflow
    
     on:
       push: # Trigger the workflow on push events
         branches:
           - main # Only trigger on push events to the main branch
    
     jobs: # Define the jobs in the workflow
       build:
         runs-on: ubuntu-latest # Run the job on the latest version of Ubuntu
    
         steps: # Define the sequence of tasks to execute in the job
           - name: Checkout code                         # Step to clone the repository
             uses: actions/checkout@v3 # GitHub Action to clone the repository
    
           - name: Set up Docker # Step to set up Docker Buildx
             uses: docker/setup-buildx-action@v2         # GitHub Action to set up Docker Buildx
    
           - name: Build Docker image # Step to build the Docker image
             run: docker build -t flask-app -f ./Dockerfile .
                 # Shell command to build a Docker image named "flask-app" using the Dockerfile located at ./Dockerfile

     # the -f ./Dockerfile flag specifies the path to the Dockerfile explicitly to avoid the "no such file or directory" error.
    
           - name: Run Docker container # Step to run the Docker container
             run: docker run -d -p 5000:5000 flask-app   # Shell command to run the container in detached mode and map port 5000
    
           - name: Wait for the server to start          # Step to add a delay to ensure the container is fully started
             run: sleep 10 # Shell command to wait for 10 seconds
    
           - name: Test the app # Step to test the application
             run: curl http://localhost:5000             # Shell command to test the application using curl

     ```

7. **Prepare, commit, and push the updated `ci-cd.yml` file:**
   - Add the changes to the staging area:
     ```powershell
     git add .github/workflows/ci-cd.yml
     ```
   - Commit the changes with a descriptive message:
     ```powershell
     git commit -m "Update CI/CD pipeline configuration"
     ```
   - Push the changes to the `main` branch of your GitHub repository:
     ```powershell
     git push origin main
     ```

### Summary for Step 5

In this step, we tested the CI/CD pipeline configured in Step 4 to ensure it works correctly. This step primarily focuses on the **Test** phase of the DevOps lifecycle, as well as the continuous integration, delivery, and deployment aspects of CI/CD.

By pushing changes to the repository, we verified that the GitHub Actions workflow was triggered, successfully built the Docker image, ran the Docker container, and tested the application. This confirmed that our CI/CD pipeline is functioning as expected, providing automated building, testing, and deployment of our application with each push to the main branch.

Specifically, we focused on:
- **Test**: By verifying the GitHub Actions workflow execution, ensuring that the application is built, tested, and deployed correctly.
- **Continuous Integration (CI)**: By automatically building and testing our code changes.
- **Continuous Delivery (CD)**: By ensuring the application is always ready for release.
- **Continuous Deployment (CD)**: By automating the deployment process.

This step confirmed that our CI/CD pipeline is operational, facilitating a consistent and reliable deployment process, reducing the risk of errors, and enhancing the efficiency of our DevOps workflow.

---
 
## Conclusion

This project demonstrates setting up a complete DevOps pipeline for a simple Flask web application, including creating and containerizing the app, setting up local testing with Docker Compose, and configuring a CI/CD pipeline using GitHub Actions. The pipeline ensures that changes to the code are automatically built, tested, and deployed. This automation facilitates a consistent and reliable deployment process, reducing the risk of errors and enhancing the efficiency of our DevOps workflow.

## License

This project, `ULE_DevOps_my_flask_app - Lab 1: "CI/CD with Docker`, is part of the course DevSecOps in Autonomous Systems, within the Master's program in Cybersecurity Research at the University of León (ULE). This project is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
