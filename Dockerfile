FROM openjdk:11-jre-slim
COPY QLKS_ASM.war /app/QLKS_ASM.war
COPY webapp-runner.jar /app/webapp-runner.jar
WORKDIR /app
CMD java -jar webapp-runner.jar --port $PORT QLKS_ASM.war