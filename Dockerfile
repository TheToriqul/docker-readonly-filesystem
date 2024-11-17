# Use Alpine Linux as the base image due to its minimal size (approximately 5MB) and security benefits
# Latest tag ensures we have the most recent updates and security patches
FROM alpine:latest

# Create a new directory named 'data' in the root filesystem
# The && operator chains commands to keep the layer count minimal
# Create a test file with sample content to demonstrate read-only functionality
# This file will be used to verify the read-only nature of the filesystem
RUN mkdir /data && echo "This is a read-only test file" > /data/test.txt

# Set the default working directory to /data
# This means all subsequent commands will execute in this directory
# When you enter the container, you'll start in this directory
WORKDIR /data

# Set the default command to run when the container starts
CMD ["sh"]