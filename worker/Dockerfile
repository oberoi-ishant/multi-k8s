# Specify the base image
FROM node:alpine

# Specify working directory
WORKDIR '/app'

# COPY package json
COPY package.json ./

# install dependencies
RUN npm install

# Copy source files
COPY ./ ./

# Specify Default command check in package.json
# we will use npm start for production.
CMD ["npm", "run", "start"]
