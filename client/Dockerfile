# stage1: Specify the base image and tag is as 'builder <any-name>'
FROM node:alpine as builder

# Specify working directory
WORKDIR '/app'

# COPY package json
COPY package.json .

# install dependencies
RUN npm install

# COPY source files
COPY ./ ./

# run npm build to build prod version of app
RUN npm run build

# stage2: Use ngnix to serve the build folder contents
# Specify the FROM command to start new stage.
# One phase/stage/block can have only ONE FROM statement
FROM nginx

# This is used to tell aws beanstalk to expose a port 3000.
# So wherever your app is  hosted on aws it will automatically do
# port mapping using this.
# for our normal running of this docker file on our machine it
# will do nothing.
EXPOSE 3000

# COPY the custom default.conf file
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# COPY the generated build folder from stage1 to the predefined
# directory /usr/share/ngnix/html in ngnix image
# https://hub.docker.com/_/nginx
# after docker build .
# docker run -p 8000:80 container id.
# 80 id default nginx port.
# /app/build as WORKDIR inside container is /app and
# build is the folder generated after npm run build
COPY --from=builder /app/build /usr/share/nginx/html
