FROM openjdk:17-alpine

WORKDIR /app

COPY ./app /app

RUN javac Main.java

CMD ["java", "Main"]
