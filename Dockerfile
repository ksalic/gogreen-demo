FROM maven:3.6.3-openjdk-8 AS maven-builder

# Since we want to execute the mvn command with RUN (and not when the container gets started),
# we have to do here some manual setup which would be made by the maven's entrypoint script
RUN mkdir -p /root/.m2 \
    && mkdir /root/.m2/repository
# Copy maven settings, containing repository configurations
COPY settings.xml /root/.m2
COPY cms /root/cms
COPY site /root/site
COPY conf /root/conf
COPY src /root/src
COPY pom-docker.xml /root/pom.xml


CMD cd /root && mvn clean install -DskipTests &&  mvn -P cargo.run -Drepo.path=storage