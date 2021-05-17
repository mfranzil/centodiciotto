FROM tomcat:10.0.6-jdk16-openjdk

LABEL maintainer="matteofranzil@gmail.com"

ADD centodiciotto.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]