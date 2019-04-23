FROM ubuntu:latest

MAINTAINER Ravi kumar G <ravikumar@oncam.com>
#RUN /bin/bash -c "source /home/ubuntu/script.sh"
ENTRYPOINT ["/home/ubuntu/script.sh"]

#Install Git Curl Wget tar vim vi 

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y tar \
    && apt-get install -y curl \
    && apt-get install -y git \
    && apt-get install -y vim \
    && apt-get install -y unzip

# Install dependencies.

RUN apt-get update \
    && apt-get install -y python3-pip python3-dev \
    && cd /usr/local/bin \
    && pip3 install --upgrade pip \
    && apt-get update \
    && apt-get install -y ansible==$ansible

# Install Terraform

RUN wget --quiet https://releases.hashicorp.com/terraform/$terraform/terraform_$terraform_linux_amd64.zip \
    && unzip terraform_$terraform_linux_amd64.zip \
    && mv terraform /usr/bin \
    && rm terraform_$terraform_linux_amd64.zip
# Filemgr-linux

RUN apt-get install -y nautilus

# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get install -y openjdk-8-jdk

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
ENV WGET_HOME=/usr/bin/wget
ENV TAR_HOME=/bin/tar
ENV CURL_HOME=/usr/bin/curl
ENV GIT_HOME=/usr/bin/git
ENV VIM_HOME=/usr/bin/vim
ENV UNZIP_HOME=/usr/bin/unzip
ENV PYTHON_HOME=/usr/bin/python
ENV ANSIBLE_HOME=/usr/bin/ansible
ENV TERRAFORM_HOME=/usr/bin/terraform
ENV NAUTILUS_HOME=/usr/bin/nautilus
ENV JAVA_HOME=/usr/bin/java
