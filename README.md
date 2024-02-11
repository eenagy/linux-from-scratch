# Linux From Scratch (LFS) - Version 12 Virtual Environment

## Introduction

This repository provides scripts and configurations to facilitate the building of a custom Linux system using the Linux From Scratch (LFS) book, version 12. The goal is to create a virtual environment to make the LFS distro building process more straightforward.

## Getting Started

### Prerequisites

- A host system with a supported Linux distribution
- QEMU for virtualization
- Basic command-line tools (bash, coreutils, sed, awk, etc.)

### Setup

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/eenagy/linux-from-scratch.git
   cd linux-from-scratch
   ```

2. Review and customize the configurations if needed.

## Usage

1. Run the setup script to prepare the build environment:

   ```bash
   ./setup.sh
   ```

2. Build the LFS distro:

   ```bash
   ./build-lfs.sh
   ```


## Customization

- Adjust configurations in `config.sh` to suit your preferences.
- Modify `packages.list` to include/exclude packages in your LFS build.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
