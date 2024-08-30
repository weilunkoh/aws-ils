# aws-ils Code Repository
Overall application for a system that enables Interactive Learning with Safeguards (ILS). Hosted on AWS with a CICD pipeline connecting to this repository.

Paper Publication: https://doi.org/10.1016/j.mlwa.2024.100583

## Using Scripts for Local Docker Setup
All provided scripts can be run by navigating to the local codes folder and running the `.bat` files in the command line. The purpose of each script that uses `docker-compose` are as follow:

### 00-build-nginx.bat
This is used to build the Docker image for the nginx container. Nginx is used to do reverse proxying so that the separate frontend and backend containers are given a unified apperance to users via the same base URL. Run this `.bat` file simply by running `00-build-nginx.bat`.

### 01-build-apps.bat
This is used to build frontend containers and backend containers. Frontend is a `next.js` application. Backend is a `Python Flask` application. Run this `.bat` file simply by running `01-build-apps.bat`.

### 02-start-apps.bat (partially working)
This is used to run all 3 containers: `nginx`, `next.js` frontend and `Python Flask` backend. There are two options but only one of them is working now. 

The first option exposes only the port of the nginx container to simulate the server-oriented environment in AWS EC2. This option can be run via `02-start-apps.bat 1`. 

The second option exposes the ports of all 3 containers to simulate the serverless enviornment in AWS Fargate. This option can be run via `02-start-apps.bat 3`. However, this option is not working now. While the actual Fargate deployment can work, the local simulation of a Fargate environment isn't.

### 03-stop-apps.bat
This is used to stop all 3 containers. There are two options with each option corresponding to the way the containers are run. Running `03-stop-apps.bat 1` stops the containers that were run via the first option. Running `03-stop-apps.bat 3` stops the containers that were run via the second option. 

## Explanation of Files Used by AWS Deployment
The full guide to do a AWS deployment can be requested separately from this README. To keep things succinct, this section will only provide a brief explanation of some important files.

### buildspec.yml
This is for `AWS Codebuild` as part of the CICD pipeline to build Docker images upon git push triggers from the GitHub source repository. 

### Dockerrun.aws.template.json
This is used by `AWS Codebuild` to produce an artifact named as `Dockerrun.aws.json` which is used by server-oriented `Elastic Beanstalk` to run containers on `EC2` instances.

### imagedefinitions.template.json
This is used by `AWS Codebuild` to produce an artifact named as `imagedefinitions.json` which is used by serverless `ECS` to run containers on `Fargate` instances.

### ecs_container_definitions_reference.json
This is used as reference for keying in definitions for `ECS Fargate` on the AWS web console. The definitions are used for running containers on `ECS Fargate`. Unlike `Elastic Beanstalk` that has definitions for both build and run defined in the same file, `ECS Fargate` has definitions for build and run defined in different areas.