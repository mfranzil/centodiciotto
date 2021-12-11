FROM tomcat:10.0.6-jdk16-openjdk

LABEL org.opencontainers.image.created="2021-05-27T10:42:00+02:00"
LABEL org.opencontainers.image.authors="Matteo Franzil <matteo.franzil+github@gmail.com>, Claudio Facchinetti <claudio.facchinetti@studenti.unitn.it>"
LABEL org.opencontainers.image.url="https://github.com/mfranzil/centodiciotto/"
LABEL org.opencontainers.image.version="2.0.2"
LABEL org.opencontainers.image.vendor="CentoDiciotto"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.ref.name="mfranzil/centodiciotto"
LABEL org.opencontainers.image.title="CentoDiciotto Web Server"

ADD centodiciotto.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]