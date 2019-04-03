# Building layer
FROM nvidia/cuda:10.1-devel AS cv_ffmpeg_builder
MAINTAINER CVision AI <info@cvisionai.com>

RUN apt-get update && apt-get install -y --no-install-recommends libx264-dev libx265-dev git yasm pkg-config

WORKDIR /working
RUN git clone --branch n9.0.18.1 https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
RUN git clone --branch n4.1.3 https://github.com/FFmpeg/FFmpeg.git

WORKDIR /working/nv-codec-headers
RUN make install

WORKDIR /working/FFmpeg
RUN ./configure --prefix=/opt/nvenc --enable-cuda --enable-cuvid --extra-cflags="-I/usr/local/cuda/include" --extra-ldflags="-L/usr/local/cuda/lib64" --enable-nonfree --enable-libnpp

RUN make -j16 && make install

# Deployment layer
FROM nvidia/cuda:10.1-runtime AS cv_ffmpeg_nvenc

RUN apt-get update && apt-get install -y --no-install-recommends libx264-152 libx265-146

COPY --from=cv_ffmpeg_builder /opt/nvenc /opt/nvenc
ENV PATH="/opt/nvenc/bin:${PATH}"

# By default NVIDIA image only enables compute,utility
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,video

WORKDIR /working
ENTRYPOINT ["ffmpeg"]
CMD ["-h"]





