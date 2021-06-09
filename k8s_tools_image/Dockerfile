FROM centos:8

RUN yum update -y
RUN yum install -y wget curl jq podman skopeo
RUN yum install -y python39
RUN yum install -y python39-pip

RUN pip3 install awscli

WORKDIR /tmp

RUN wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    cp kubectl /usr/bin && \
    chmod 777 /usr/bin/kubectl

RUN mkdir -p /home/tools

RUN groupadd -r tools && useradd -r -u 1001 -g tools -d /home/tools tools

WORKDIR /home/tools

RUN mkdir -p .aws

RUN chown -R tools:tools /home/tools

ENTRYPOINT ["/bin/sh","-c"]
CMD [""]
USER tools
WORKDIR /home/tools