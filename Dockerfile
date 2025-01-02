# Dockerfile

# Specify the base image
FROM python:3.9-slim

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the app.py application file from my local machine to the /app directory in the container
COPY app.py /app/

# Install the Flask dependency inside the container
RUN pip install flask

# Expose port 5000, which Flask uses to run the web server
EXPOSE 5000

# Run the Flask application when the container starts
CMD ["python", "app.py"]