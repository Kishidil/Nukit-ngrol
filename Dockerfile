0# Yengil Alpine bazasidan foydalanamiz
FROM alpine:latest

# Kerakli paketlarni o‘rnatamiz
RUN apk add --no-cache openjdk17 curl bash jq

# Ishchi katalogni yaratamiz
WORKDIR /nukkit

# Nukkit serverni yuklab olamiz
RUN curl -o nukkit.jar https://motci.cn/job/Nukkit-MOT/job/master/lastSuccessfulBuild/artifact/target/Nukkit-MOT-SNAPSHOT.jar

# EULA va server sozlamalarini yozamiz
RUN echo "online-mode=false" > server.properties

# Ngrok ni yuklab olamiz
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip \
    && unzip ngrok.zip \
    && mv ngrok /usr/local/bin/ngrok \
    && rm -f ngrok.zip

# Ngrok token uchun environment variable
ENV NGROK_AUTHTOKEN=""

# Serverni ishga tushirish skriptini qo‘shamiz
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Konteyner ishga tushganda start.sh bajariladi
CMD ["/bin/bash", "/start.sh"]
