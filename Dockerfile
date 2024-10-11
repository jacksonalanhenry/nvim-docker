# Use an official lightweight image
FROM debian:bullseye-slim

# Set environment variables for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Instructions:
# Use the --build-arg NVIM_ROOT_DIR=<your_directory> argument to specify the 
# Neovim root directory during the build process. If not provided, the 
# default will be /home.
ARG NVIM_ROOT_DIR=/home

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    software-properties-common \
    git \
    build-essential \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    unzip \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install the latest stable version of Neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root /root/nvim-squashfs-root && \
    ln -s /root/nvim-squashfs-root/AppRun /usr/bin/nvim && \
    rm nvim.appimage

# Clone the kickstart.nvim repository into the Neovim configuration folder
RUN git clone https://github.com/nvim-lua/kickstart.nvim.git /root/.config/nvim

# Install Neovim plugins and configurations
RUN nvim --headless +PackerSync +qa

# Set the working directory to the user-defined path or default to /home
WORKDIR ${NVIM_ROOT_DIR}



# Set the entrypoint to bash (you can switch this to nvim if needed)
ENTRYPOINT ["nvim"]

