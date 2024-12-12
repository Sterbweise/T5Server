#!/bin/bash

# Build the Docker image
docker build -f .config/utility/dev/Dockerfile -t t5server-tests .

# Run the tests in a new container
docker run --rm t5server-tests