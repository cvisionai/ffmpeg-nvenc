help:
	echo "Valid Targets: [shell, build]"

build: Dockerfile
	nvidia-docker build -t cvisionai/ffmpeg-nvenc -f Dockerfile .

shell: build
	nvidia-docker run --rm -ti --entrypoint=bash cvisionai/ffmpeg-nvenc
