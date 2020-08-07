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
     gnupg2 \
     net-tools \
     vim \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce

RUN apt-get install -y docker-ce
RUN usermod -a -G root jenkins
RUN usermod -a -G docker jenkins

USER jenkins
