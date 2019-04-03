# ffmpeg-nvenc

This project is the recipe for a docker image enabling nvenc in ffmpeg.

# Licensing

The files in this repository are licensed under the MIT License.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The docker image itself is based on the [NVIDIA CUDA Image](https://hub.docker.com/r/nvidia/cuda/) -- users of this image should be aware of the EULA associated
with the software provided by NVIDIA. 

The docker image also contains a layer containing ffmpeg. The user of this image
recognizes they are using the system library provided by NVIDIA to facilitate
advanced features in ffmpeg.

# Makefile usage

The include makefile supports two targets:

- build : constructs the docker image)
- shell : opens a debug shell into the docker image

