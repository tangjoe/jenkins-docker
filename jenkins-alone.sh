#!/bin/bash
#              -v $(which docker):/usr/bin/docker \
#              -v $HOME/clairs-canner:/usr/bin/clair-scanner \

docker run -d --name jenkins-alone --net cicd_net \
              -v /var/run/docker.sock:/var/run/docker.sock \
              -p 8888:8080 jenkinsdocker:2.235.3
