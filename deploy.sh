# build and tag the the images
docker build -t ishantoberoi/multi-client:latest -t ishantoberoi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ishantoberoi/multi-server:latest -t ishantoberoi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ishantoberoi/multi-worker:latest -t ishantoberoi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# since we have already logged in to docker in travis yml
# and this script is run by travis yml, we do not need to login to docker again

# push images
docker push ishantoberoi/multi-client:latest
docker push ishantoberoi/multi-server:latest
docker push ishantoberoi/multi-worker:latest

docker push ishantoberoi/multi-client:$SHA
docker push ishantoberoi/multi-server:$SHA
docker push ishantoberoi/multi-worker:$SHA

# Since in travis yml we already configured google cloud(gcloud)
# and gcloud is in charge of kubectl command (gcloud components update kubectl)
# so we can directly run kubectl commands
# inside the travis environment

# So apply all files
kubectl apply -f k8s

# Tag images with latest version
# Command to update an OBJECT inside the cluster
# kubectl set <property> <object-type>/<object-name> <container-name>=<new-property>

# Note By default if you do  not specify the version number of image
# to use, it is consider as lastest. So
# kubectl set image deployment/server-deployment server=ishantoberoi/multi-server
# is equal to
# kubectl set image deployment/server-deployment server=ishantoberoi/multi-server:latest
# So k8s things it is already running latest version and there is nothing to update.
# Image (tag-image-latest-issue.png)
# So will use dynamic tagging of images using git sha.
# Get current git sha:  git rev-parse HEAD
# SHA is unique id of commit ~ commit id
# Image(solve-tag-image-git-sha.png)
# Image (why-use-tag-latest.png)
# So we will tag image with two tags:
# one :latest,so if new engineer clones project and runs kubectl apply -f k8s,
# he gets all the latest images as :latest tag is implicit in the deployment files
# their image: ishantoberoi/multi-client means ishantoberoi/multi-client:latest.
# second: with git sha to push the new image with new commit id to give a unique name, so that k8s can update
# the deployment.
# With this approcah we have two benefits,
# latest image remains updated as latest
# and codewise we have an image per commit id, so helpful in debugging also
# We can see what image:commit-id is running on prod, checkout that git commit and debug locally.

# taggging with sha helps get image a new tag so that k8s can update the
# deployment with new image.

kubectl set image deployment/client-deployment client=ishantoberoi/multi-client:$SHA
kubectl set image deployment/server-deployment server=ishantoberoi/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=ishantoberoi/multi-worker:$SHA

