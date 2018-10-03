FROM birchwoodlangham/x11-ubuntu-base:latest

MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-mark hold iptables && \
    apt-get install -y xubuntu-desktop && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# startscript to copy dotfiles from /etc/skel
# runs either CMD or image command from docker run
RUN echo '#! /bin/sh\n\
[ -n "$HOME" ] && [ ! -e "$HOME/.config" ] && cp -R /etc/skel/. $HOME/ \n\
unset DEBIAN_FRONTEND \n\
exec $*\n\
' > /usr/local/bin/start && chmod +x /usr/local/bin/start 

ENTRYPOINT ["/usr/local/bin/start"]
CMD ["startxfce4"]

ENV DEBIAN_FRONTEND newt
