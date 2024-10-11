#!/bin/bash

# Check if NVIM_DOCKER_MOUNTS is set
if [ -z "$NVIM_DOCKER_MOUNTS" ]; then
  echo "Warning: NVIM_DOCKER_MOUNTS is not set. Continuing without default mount files."
fi

# Build the Docker volume arguments from NVIM_DOCKER_MOUNTS
VOLUME_ARGS=$(echo $NVIM_DOCKER_MOUNTS | sed 's/\([^:]*\)/-v \1:\1/g')

# Function to convert relative paths to absolute paths
get_abs_path() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# Process additional paths passed as arguments
if [ "$#" -gt 0 ]; then
  for path in "$@"; do
    # Convert the path to absolute path
    abs_path=$(get_abs_path "$path")
    
    if [ -d "$abs_path" ]; then
      # Mount to the same location inside the container
      VOLUME_ARGS="$VOLUME_ARGS -v $abs_path:$abs_path"
    else
      echo "Warning: $path is not a valid directory. Skipping."
    fi
  done
fi

# Run the Neovim Docker container with the mounted volumes
docker run -it $VOLUME_ARGS nvim-docker
