# syntax=docker/dockerfile:1
FROM maven:3-openjdk-17-slim
RUN apt-get update && apt-get install --no-install-recommends -y npm
WORKDIR /app
COPY . .
RUN --mount=type=cache,target=/root/.m2/repository mvn package -B -DskipTests=true
WORKDIR /app/top-api/target/generated-sources/openapi/axios
RUN npm install && npm pack && mkdir -p /base && mv /app/top-api/target/generated-sources/openapi/axios/*.tgz /base/top-api.tgz
ENTRYPOINT ["/bin/echo"]
CMD ["This base image is only needed at the build step and thus exiting as planned."]
