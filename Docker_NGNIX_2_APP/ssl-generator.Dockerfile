FROM alpine:latest

RUN apk --no-cache add openssl

WORKDIR /

# Copy the OpenSSL configuration file (openssl.cnf) to the container
COPY openssl.cnf .

# Generate the private key and certificate signing request (CSR)
RUN openssl req -new -nodes -out csr.pem -keyout key.pem -config openssl.cnf

# Generate the self-signed certificate using the private key and CSR
RUN openssl x509 -req -days 365 -in csr.pem -signkey key.pem -out cert.pem

CMD ["tail", "-f", "/dev/null"]
