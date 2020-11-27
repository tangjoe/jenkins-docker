# MUST READ

##### 0. Create docker repository in Nexus, docker-role in Security/Role and docker in Security/Users
##### 
##### 1. Enable "Docker Bearer Token Realm" in Nexus -> Administration -> Security -> Realms
##### 
##### 2. Add below in the host docker engine
#####
#####    "insecure-registries": [
#####      "127.0.0.1:8082",
#####      "127.0.0.1:5000"
#####    ]
##### 
##### 3. From Terminal of Host:
#####     # docker login 127.0.0.1:8082 // docker:P@sw0rd
#####     # docker tag alpine:3.6 127.0.0.1:8082/myalpine:3.6
#####     # docker push 127.0.0.1:8082/myalpine:3.6
##### 
##### 4. From Jenkins container:
#####     # docker login 127.0.0.1:8082 // docker:P@sw0rd
#####     # docker tag alpine:3.6 127.0.0.1:8082/myalpine:3.6
#####     # docker push 127.0.0.1:8082/myalpine:3.6
##### 

##### Create a raw repository for XML configuration
##### Upload the file
##### --> curl -v -u rawxml:P@ssw0rd --upload-file pom.xml http://localhost:8081/nexus/repository/raw-xml-config/pom.xml
