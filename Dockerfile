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

# Runtime template
ENV PATH=/opt/bitnami/ruby/bin:$PATH

COPY . /app
RUN chown -R bitnami:bitnami /app
USER bitnami
WORKDIR /app

RUN bundle install

EXPOSE 3000
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "3000"]
