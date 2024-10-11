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
