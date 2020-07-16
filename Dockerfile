FROM jenkins/jenkins:lts
  
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY plugin-list.txt /usr/share/jenkins/ref/plugin-list.txt
RUN /usr/local/bin/install-plugins.sh < usr/share/jenkins/ref/plugin-list.txt

USER root

RUN apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
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
