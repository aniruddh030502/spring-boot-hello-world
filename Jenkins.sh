#!/bin/bash
echo "Starting Docker build and push..."

# Navigate to the directory containing the Dockerfile if necessary
# cd your-app-directory

# Build the Docker image
docker build -t aniruddh030502/springhelloworldimg:v1 .

# Log in to Docker Hub
echo "Logging in to Docker Hub..."
docker login -u aniruddh030502 -p *******************
if [ $? -eq 0 ]; then
  echo "Successfully logged in to Docker Hub."
else
  echo "Error logging in to Docker Hub. Aborting."
  exit 1
fi

# Push the Docker image
echo "Pushing Docker image..."
docker push aniruddh030502/springhelloworldimg:v1
if [ $? -eq 0 ]; then
  echo "Docker image pushed successfully."
else
  echo "Error pushing Docker image. Aborting."
  exit 1
fi

echo "Docker build and push complete."
kubectl apply -f deployment.yaml
if [ $? -eq 0 ]; then
  echo "Kubernetes deployment applied successfully."
else
  echo "Error applying Kubernetes deployment. Aborting."
  exit 1
fi
kubectl apply -f springboot-service.yaml
if [ $? -eq 0 ]; then
  echo "Kubernetes services using NodePort applied successfully."
else
  echo "Error applying Kubernetes Services. Aborting."
  exit 1
fi
echo "Deployment Complete."
