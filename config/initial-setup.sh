#!/bin/bash

# Define variables
TARGET_DIR="/var/jenkins_home2/"
SOURCE_DIR="../ansible"

# Create the target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
  echo "Creating directory $TARGET_DIR..."
  sudo mkdir -p "$TARGET_DIR"
else
  echo "Directory $TARGET_DIR already exists."
fi

# Copy the source directory to the target directory
echo "Copying $SOURCE_DIR to $TARGET_DIR..."
sudo cp -r "$SOURCE_DIR" "$TARGET_DIR"

# Run docker-compose up --build
echo "Running docker-compose up --build..."
docker compose up --build

# Set the correct permissions
echo "Setting permissions for $TARGET_DIR..."
#sudo chown -R 1000:1000 "$TARGET_DIR" # Replace 1000:1000 with the appropriate user and group ID if necessary
sudo chmod -R 755 "$TARGET_DIR"

echo "Operation completed."