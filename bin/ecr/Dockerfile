FROM centos:8

RUN yum update -y
RUN yum install -y wget curl
RUN yum install -y python39
RUN yum install -y python39-pip

RUN pip3 install awscli

WORKDIR /tmp

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    cp kubectl /usr/bin && \
    chmod 777 /usr/bin/kubectl

RUN mkdir -p /home/aws

RUN groupadd -r aws && useradd -r -u 1001 -g aws -d /home/aws aws

RUN mkdir -p .aws

RUN chown -R aws:aws /home/aws

ENTRYPOINT ["/bin/sh","-c"]
CMD [""]
USER aws
WORKDIR /home/aws