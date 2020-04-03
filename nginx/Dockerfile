# base image
FROM nginx

# Copy our config file in the nginx location
# it will override the default file there.
# In the default.conf we have a proxy_pass for sockjs-node
# that is only dev purpose. If you strictly dont need it in prod
# then creare a new config file for prod without that rule and use here.
# Else leave it not a big deal.
COPY ./default.conf /etc/nginx/conf.d/default.conf