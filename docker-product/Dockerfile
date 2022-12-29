FROM ubuntu:22.04

COPY . /product/

WORKDIR /product

RUN apt-get update
RUN apt-get install -y locales
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN make build-pip

EXPOSE 8080

RUN cp Makefile ../Makefile
RUN cd ..
RUN ls -la

CMD ["make", "run-here"]
