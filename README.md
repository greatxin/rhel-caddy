# RHEL7 with Caddy server v0.10.4
This Dockerfile provides a basic RHEL7 OpenShift image with Caddy Server installed.
# Deploying this Application within OpenShift
This image builder can be deployed using the following YAML:
    kind: List
    apiVersion: v1
    items:

    - kind: ImageStream
      apiVersion: v1
      metadata:
        name: rhel7
      spec:
        tags:
        - from:
            kind: DockerImage
            name: registry.access.redhat.com/rhel7:latest
          name: latest

    - kind: ImageStream
      apiVersion: v1
      metadata:
        labels:
          app: rhel7-caddy
        name: rhel7-caddy
      spec: {}

    - kind: BuildConfig
      apiVersion: v1
      metadata:
        labels:
          app: rhel7-caddy
        name: rhel7-caddy
      spec:
        output:
          to:
            kind: ImageStreamTag
            name: rhel7-caddy:v0.10.4
        source:
          type: Git
          git:
            uri: https://github.com/rbaumgar/rhel-caddy.git
        strategy:
          dockerStrategy:
            from:
              kind: ImageStreamTag
              name: rhel7:latest
          type: Docker
        triggers:
        - type: ConfigChange
        - type: ImageChange
          imageChange: {}
