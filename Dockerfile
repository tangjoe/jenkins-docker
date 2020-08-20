FROM jenkins/jenkins:2.235.3-lts
  
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY plugin.txt /usr/share/jenkins/ref/plugin.txt
RUN /usr/local/bin/install-plugins.sh < usr/share/jenkins/ref/plugin.txt

ADD jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml

COPY Job1_testing_tools_config.xml /usr/share/jenkins/ref/jobs/Job1_testing_tools/config.xml
COPY Job2_testing_docker_config.xml /usr/share/jenkins/ref/jobs/Job2_testing_docker/config.xml

USER root

RUN apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     net-tools \
     vim \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey-1; apt-key add /tmp/dkey-1 && \
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg > /tmp/dkey-2; apt-key add /tmp/dkey-2 && \
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce && \
apt-get -y install kubectl && \
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
apt-get clean autoclean && \
apt-get autoremove --yes && \
rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN usermod -a -G root jenkins
RUN usermod -a -G docker jenkins

USER jenkins
