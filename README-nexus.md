# MUST

1. Enable "Docker Bearer Token Realm" in Nexus -> Administration -> Security -> Realms

2. Add
   "insecure-registries": [
     "127.0.0.1:8082",
     "127.0.0.1:5000"
   ]

3. From Terminal of Host:
    # docker login 127.0.0.1:8082 // docker:P@sw0rd
    # docker tag alpine:3.6 127.0.0.1:8082/myalpine:3.6
    # docker push 127.0.0.1:8082/myalpine:3.6

4. From Jenkins container:
    # docker login 127.0.0.1:8082 // docker:P@sw0rd
    # docker tag alpine:3.6 127.0.0.1:8082/myalpine:3.6
    # docker push 127.0.0.1:8082/myalpine:3.6

