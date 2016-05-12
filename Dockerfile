## BUILDING
##   (from project root directory)
##   $ docker build -t prydonius-bitnami-docker-redmine .
##
## RUNNING
##   $ docker run -p 3000:3000 prydonius-bitnami-docker-redmine
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r06

MAINTAINER Bitnami <containers@bitnami.com>

LABEL com.bitnami.stacksmith.id="6t044em" \
      com.bitnami.stacksmith.name="prydonius/bitnami-docker-redmine"

ENV STACKSMITH_STACK_ID="6t044em" \
    STACKSMITH_STACK_NAME="prydonius/bitnami-docker-redmine" \
    STACKSMITH_STACK_PRIVATE="1"

# Runtime
RUN bitnami-pkg install ruby-2.1.9-2 --checksum d9a014bb284fe1bd181008aa7f78b70b5259a93014a175df0a7e42084b2e2dd4

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Additional modules required
RUN bitnami-pkg install imagemagick-6.7.5-10-3 --checksum 617e85a42c80f58c568f9bc7337e24c03e35cf4c7c22640407a7e1e16880cf88
RUN bitnami-pkg install mysql-libraries-10.1.11-1 --checksum de90c294a3319ab33f82d4af09d0f4942fcc831268344146b8347ce885d52c29
RUN bitnami-pkg install mysql-client-10.1.11-1 --checksum 8dea362fbff8ac4cc0342d9e9b62c66498fd8be59ab2e106aefd085888b66b58
RUN bitnami-pkg install base-functions-1.0.0-1 --checksum ddd7aea91e039e07b571d5f4e589bedb5a1ae241e625f4a06a64a7ede439c7b8

# Install application
ENV BITNAMI_APP_NAME=redmine \
    BITNAMI_APP_VERSION=3.2.1-3
RUN bitnami-pkg unpack redmine-3.2.1-1 --checksum c1faac8c6b30fc61f0a7486605395ef852cfce6e6cbdca7cdbdfb2bfe2476234

# Setting entry point
COPY rootfs /
ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["harpoon", "start", "--foreground", "redmine"]
