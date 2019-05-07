############################################################
# SSH server
############################################################

FROM nguyenductamlhp/docker-supervisord:16.04

MAINTAINER Michel Meyer <mmeyer@trobz.com> Nguyen Duc Tam <nguyenductamlhp@gmail.com>


# Install common dependencies
############################################################

RUN apt-get install -y \
    git curl wget net-tools lynx nano htop screen \
    sudo openssh-server

# screen

RUN chmod 0777 /var/run/screen

# vim

ADD config/vim/vim.tar.gz /tmp/setup

# ssh

RUN mkdir -p /var/run/sshd
RUN chmod 0755 /var/run/sshd

# configure ssh server service with supervisord
COPY config/supervisor/sshd.conf /etc/supervisor/conf.d/sshd.conf

# Finalization
############################################################

EXPOSE 22

ADD scripts/start/init/05_ssh.sh /usr/local/docker/start/init/05_ssh.sh
ADD scripts/start/init/06_vim.sh /usr/local/docker/start/init/06_vim.sh
