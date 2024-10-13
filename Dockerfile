# Use an official lightweight image
FROM debian:bullseye-slim

# Set environment variables for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Instructions:
# Use the --build-arg NVIM_ROOT_DIR=<your_directory> argument to specify the 
# Neovim root directory during the build process. If not provided, the 
# default will be /home.
ARG NVIM_ROOT_DIR=/home
ARG NVIM_CONFIG_PATH=""
ARG NO_CONFIG=false

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    locales \
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
    python3-venv \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8


# Download and install the latest stable version of Neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root /root/nvim-squashfs-root && \
    ln -s /root/nvim-squashfs-root/AppRun /usr/bin/nvim && \
    rm nvim.appimage

# Copy the local Neovim configuration if provided and NO_CONFIG is false
COPY ${NVIM_CONFIG_PATH} /root/.config/nvim

# Install Neovim plugins and configurations
RUN nvim --headless +PackerSync +qa
RUN nvim --headless +"Lazy! sync" +qa
RUN nvim --headless +"Lazy! install" +qa

# Set the working directory to the user-defined path or default to /home
WORKDIR ${NVIM_ROOT_DIR}



# Set the entrypoint to bash (you can switch this to nvim if needed)
ENTRYPOINT ["nvim"]

