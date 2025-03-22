FROM openjdk:17-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*
COPY QLKS_ASM.war /app/QLKS_ASM.war
COPY webapp-runner.jar /app/webapp-runner.jar
WORKDIR /app
CMD java -jar webapp-runner.jar --port $PORT QLKS_ASM.war