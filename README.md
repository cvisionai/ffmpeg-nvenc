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

# Usage the image

To do something like transcode an video, one can use the docker image as an
executable image, and arguments are forwarded to the ffmpeg executable inside
the container: 

The following example reads in `file.mp4` and re-encodes using `hevc` to
`file_1080p.mp4`

```
nvidia-docker run -v $(pwd):/working cvisionai/ffmpeg-nvenc -y -i file.mp4 -c:v hevc_nvenc -filter:v "hwupload_cuda,scale_npp=w=1920:h=1080,hwdownload,format=yuv420p" -strict 2 -tag:v hvc1 -preset medium file_1080p.mp4
```

# Notes

CRF setting in the nv_encoder for an estimted crf of 19 could look like this:

```
-preset llhq -rc:v vbr_minqp -qmin:v 19 -qmax:v 21 -b:v 2500k -maxrate:v 5000k
```

One can do a fixed QP:
```
-rc constqp -qp 21
```

