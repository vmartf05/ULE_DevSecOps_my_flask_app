# ULE_DevSecOps_my_flask_app - Lab 1: "CI/CD with Docker" 

### Goal Workflow (action on GitHub) to check that a Web Application (in Python) works. 
### Steps 
1. Create an Application
2. Create a Dockerfile
3. (Optional) Docker Compose for local testing
4. Configure GitHub Actions
5. Test the Pipeline

# ULE_DevSecOps_my_flask_app

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation and Setup](#installation-and-setup)
4. [Step 1: Creating an Application](#creating-an-application)
5. [Step 2: Creating a Dockerfile](#creating-a-dockerfile)
6. [Step 3: Utilizing Docker Compose for local testing](#utilizing-docker-compose-for-local-testing)
7. [Step 4: Configuring GitHub Actions](#configuring-github-actions)
8. [Step 5: Testing the CI/CD Pipeline](#testing-the-cicd-pipeline)
9. [Conclusion](#conclusion)

## Introduction

This project demonstrates setting up a DevSecOps pipeline for a simple Flask web application. The steps include creating a Flask app, containerizing it using Docker, and setting up a CI/CD pipeline with GitHub Actions.

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
  - CLick on `Aceptar`, `Aceptar`, `Aceptar` to save the changes.

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

## Step 1: Create an Application

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

We then added the `app.py` file to our repository using the `git add`, `git commit`, and `git push` commands, successfully integrating the code into version control (which is part of the continuous integration (CI) process). The full CI/CD pipeline setup and automation (which involves more steps, such as automated testing and deployment) will be addressed in a later step.

---

## Step 2: Create a Dockerfile

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

In the **Dev** part of DevOps, there are four main phases: **Plan**, **Code**, **Build**, and **Test**, while the **Ops** part includes **Launch**, **Deploy**, **Operate**, and **Monitor**. In this step, we focused on building and containerizing the Flask web application, thus covering the **Build** and **Launch** phases of the DevOps lifecycle.

We created a Dockerfile to define the instructions for building a Docker image of the web application and then built the Docker image. After that, we ran a Docker container using the created image, effectively moving towards the **Launch** phase by running the containerized application.

Thus, we continued the process of setting up the Continuous Integration (CI) part of the CI/CD pipeline by containerizing the application (which makes it portable and easier to deploy across different environments). Continuous Delivery and Continuous Deployment (CD) involve additional steps like automated testing and deployment, which will be addressed in a later step as part of the full CI/CD pipeline setup and automation.

---

## Step 3: Create a Dockerfile




---
 
## Conclusion

This project demosntrates setting up a complete DevSecOps pipeline for a simple Flask web application, including creating and containerizing the app, and setting up CI/CD using GitHub Actions. The pipeline ensures that changes to the code are automatically built, tested and deployed, strealining the development and release process.
