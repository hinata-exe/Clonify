# Use a modern, supported base image (Debian Bookworm) with Python 3.11
FROM python:3.11-slim-bookworm

# Set DEBIAN_FRONTEND to noninteractive to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install curl and gnupg to add NodeSource repository, then clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl gnupg \
    && rm -rf /var/lib/apt/lists/*

# Add NodeSource repository for Node.js 20.x (LTS version is more stable)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

# Install Node.js, ffmpeg, git, and then clean up apt cache
# YAHAN PAR 'git' ADD KIYA GAYA HAI
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg nodejs git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the application files into the container
COPY . /app/

# Set the working directory
WORKDIR /app/

# Install Python dependencies from requirements.txt
RUN pip3 install --no-cache-dir -U -r requirements.txt

# Command to run the application
CMD ["bash", "start"]
