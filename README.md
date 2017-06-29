# rhel-caddy
OpenShift container for Caddy based on RHEL
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
          app: rhel7-java-180-oracle
        name: rhel7-java-180-oracle
      spec: {}

    - kind: BuildConfig
      apiVersion: v1
      metadata:
        labels:
          app: rhel7-java-180-oracle
        name: rhel7-java-180-oracle
      spec:
        output:
          to:
            kind: ImageStreamTag
            name: rhel7-java-180-oracle:latest
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
