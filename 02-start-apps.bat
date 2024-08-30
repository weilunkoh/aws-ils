set expose_option=%1
docker-compose -p aws-ils -f ./docker-compose-expose%expose_option%.yml up -d