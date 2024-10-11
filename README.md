# Neovim Docker Image

This repository contains a Dockerfile to build a Docker image that runs the latest stable version of [Neovim](https://neovim.io/) along with the [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) configuration.

## How to Build the Docker Image

To build the Docker image, follow the instructions below. You can specify a custom root directory for Neovim using the `NVIM_ROOT_DIR` build argument.

### Building with Default Settings

If you don't provide a custom `NVIM_ROOT_DIR`, the working directory inside the container will default to `/home`.

```bash
docker build -t nvim-docker .
```

### Building with a Custom Neovim Root Directory

```bash
docker build --build-arg NVIM_ROOT_DIR=/path/to/your/dir -t nvim-docker .
```
## Running Neovim in the Docker Container
Once the Docker image is built, you can run Neovim using the following command:

```bash
docker run -it nvim-docker
```

If you want to mount local files or directories into the container, you can use the -v option:

```bash
docker run -it -v /path/to/local/dir:/path/in/container nvim-docker
```
This will mount the local directory into the container, making it accessible to Neovim.


## Using the `open-nvim.sh` Script
The `open-nvim.sh` script simplifies running Neovim in a Docker container with custom directory mounts. This script allows you to mount specific directories or files into the container without manually typing the docker run command.

## Script Features
- Environment Variable for Default Mounts: The script uses the `NVIM_DOCKER_MOUNTS` environment variable to automatically mount specific directories whenever Neovim is launched via Docker.

- Passing Custom Paths as Arguments: You can also pass directories or files as arguments to the script, and these will be mounted in the Docker container under the same paths.

- If the `NVIM_DOCKER_MOUNTS` environment variable *is not* set, the script will print a warning but continue running. You can still provide directories or files as arguments, and they will be mounted.

### Example Usage

```bash
./open-nvim.sh
```
#### Running Neovim with Custom Paths: 

You can pass directories as arguments to mount them in the Docker container:

```bash
./open-nvim.sh ~/notes /home/user/projects/
```
Directories: Will be mounted inside the container at the same path as on your host.

#### Running Without `NVIM_DOCKER_MOUNTS`: 

If the `NVIM_DOCKER_MOUNTS` environment variable is not set, the script will continue running, and you can still specify paths to mount:

```bash
unset NVIM_DOCKER_MOUNTS
./open-nvim.sh ~/documents 
```

## Neovim Configuration
This Docker image includes the kickstart.nvim configuration for Neovim. The configuration will be loaded automatically when you run Neovim in the container.

### Customization
You can modify the Dockerfile to include additional plugins or settings based on your needs. For example, if you prefer a different Neovim configuration, you can clone your configuration into the appropriate directory inside the container during the build process.

#### Example Modification
To use your own Neovim configuration, modify this line in the Dockerfile:

```Dockerfile
RUN git clone https://github.com/nvim-lua/kickstart.nvim.git /root/.config/nvim
```
Replace the URL with the link to your own configuration repository.

## License
This project is open-source and distributed under the MIT License.
