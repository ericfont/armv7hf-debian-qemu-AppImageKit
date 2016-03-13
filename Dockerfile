FROM ericfont/armv7hf-debian-qemu-musescore-dependencies:latest

RUN [ "cross-build-start" ]

# no regular gcc, but CMAKE needs to know to use 4.7
RUN ln -s /usr/bin/gcc-4.7 /usr/bin/gcc
RUN ln -s /usr/bin/g++-4.7 /usr/bin/g++

# get AppImageKit source release
RUN wget https://github.com/probonopd/AppImageKit/archive/5.tar.gz
RUN tar -xvzf 5.tar.gz

# need to manually copy some libs
RUN apt-get install fuse libglade2-0 libvte9 ruby-vte unionfs-fuse
RUN cp /usr/lib/libglade-2.0.so.0 AppImageKit-5/binary-dependencies/armv7l/
RUN cp /usr/lib/libvte.so.9 AppImageKit-5/binary-dependencies/armv7l/
RUN cp /usr/lib/ruby/vendor_ruby/1.8/arm-linux-eabihf/vte.so AppImageKit-5/binary-dependencies/armv7l/
RUN cp /usr/bin/unionfs-fuse AppImageKit-5/binary-dependencies/armv7l/

RUN apt-get install python
RUN cd AppImageKit-5 && ./build.sh

RUN [ "cross-build-end" ]  
