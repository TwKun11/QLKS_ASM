# Sử dụng image Java chính thức
FROM openjdk:11-jre-slim

# Copy file WAR và webapp-runner.jar vào container
COPY QLKS_ASM.war /app/QLKS_ASM.war
COPY webapp-runner.jar /app/webapp-runner.jar

# Đặt thư mục làm việc
WORKDIR /app

# Lệnh để chạy ứng dụng
CMD ["java", "-jar", "webapp-runner.jar", "--port", "$PORT", "QLKS_ASM.war"]