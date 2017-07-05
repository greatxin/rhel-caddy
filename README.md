# Caddy server v0.10.4 on RHEL
This Dockerfile provides a basic RHEL7 OpenShift image with Caddy Server installed.
# Deploying this Application within OpenShift
This Caddy server can be deployed using the following YAML:

    oc new-project caddy
    oc create -f https://raw.githubusercontent.com/rbaumgar/rhel-caddy/master/caddy.yaml

Check if the caddy pod is runnig with the command

    oc get pod -w
    
until a pod with the name rhel7-caddy-1-xxxxx is running.

You can copy your files to the server with

    oc cp myfile rhel7-caddy-1-xxxxx:.
    
Access the caddy server in your browser. The URL is available with the following command under HOST/PORT

    oc get route caddy
