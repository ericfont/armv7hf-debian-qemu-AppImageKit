FROM ericfont/armv7hf-debian-qemu

RUN [ "cross-build-start" ]

RUN apt-get update
RUN apt-get install wget ca-certificates

# get AppImageKit source release build script
RUN wget https://raw.githubusercontent.com/ericfont/AppImageKit/origin/feature/arm_builds_docker/build.sh

RUN bash build.sh --fetch-dependencies-only

RUN [ "cross-build-end" ]  
