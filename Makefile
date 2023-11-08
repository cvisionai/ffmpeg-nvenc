help:
	echo "Valid Targets: [shell, build]"

build: Dockerfile
	docker build -t cvisionai/ffmpeg-nvenc -f Dockerfile .

shell: build
	docker run --rm -ti --entrypoint=bash --gpus all -v /data:/data cvisionai/ffmpeg-nvenc
