#!/bin/bash

curl http://localhost:9000/api/plugins/installed| jq '.[][] | .name'
