# note: latest is jessie
FROM resin/armv7hf-debian-qemu

ADD 5.tar.gz /
VOLUME [ "/AppImageKit-5" ]

RUN [ "cross-build-start" ]

#ADD https://github.com/probonopd/AppImageKit/archive/5.tar.gz 5.tar.gz
# no regular gcc, but CMAKE needs to know to use 4.7
RUN apt-get clean && apt-get update && apt-get install -y python fuse libglade2-0 libvte9 ruby-vte unionfs-fuse

# get AppImageKit source release
#RUN wget https://github.com/probonopd/AppImageKit/archive/5.tar.gz
#RUN tar -xvzf 5.tar.gz
# need to manually copy some libs
#RUN apt-get install fuse libglade2-0 libvte9 ruby-vte unionfs-fuse
RUN cp /usr/lib/arm-linux-gnueabihf/libglade-2.0.so.0 /AppImageKit-5/binary-dependencies/armv7l/
RUN cp /usr/lib/libvte.so.9 AppImageKit-5/binary-dependencies/armv7l/
RUN cp /usr/lib/arm-linux-gnueabihf/ruby/vendor_ruby/2.1.0/vte.so AppImageKit-5/binary-dependencies/armv7l/
RUN cp /usr/bin/unionfs-fuse AppImageKit-5/binary-dependencies/armv7l/

#RUN apt-get install python
RUN cd AppImageKit-5 && ./build.sh

#RUN printf "#include <stdio.h> \n int main() { printf(\"HI\"); return 0; }" > hi.c
#RUN cat hi.c
#RUN /usr/bin/gcc-4.7 hi.c -o hi
#RUN ./hi

#RUN mkdir hi.AppDir
#RUN cp AppImageKit-5/AppRun hi.AppDir/
#RUN mkdir hi.AppDir/usr
#RUN mkdir hi.AppDir/usr/bin
#RUN cp hi hi.AppDir/usr/bin/hi
#RUN mkdir hi.AppDir/usr/lib
#RUN printf "[Desktop Entry]\nName=hi\nExec=hi\nIcon=hi" > hi.AppDir/hi.desktop

#RUN ./hi.AppDir/AppRun

#RUN export APP=hi && ./AppImageAssistant.AppDir/package $APP.AppDir $APP.AppImage && ./APP.AppImage
#RUN AppImageKit-5/
RUN [ "cross-build-end" ]  

