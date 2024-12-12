@echo off

REM Delete old containers and images
docker rm -f $(docker ps -a -q --filter ancestor=t5server-tests)
docker rmi t5server-tests

REM Build the Docker image
docker build -f .config/utility/dev/Dockerfile -t t5server-tests .

REM Run the tests in a new container
docker run --rm t5server-tests

pause