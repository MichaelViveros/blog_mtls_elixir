# Certs

`client.crt` contains the dummy client certificate (CN = dummy-mtls-client.com) and `root_ca.crt` contains the self-signed dummy root CA certificate (CN = Dummy Root CA).

## Commands

Here are the commands used to generate the certificates.

Generate the root CA key. The passphrase used was `mtls`.
```
openssl genrsa -des3 -out root_ca.key 4096
```
Generate a self-signed cert for the root CA:
```
openssl req -new -x509 -days 3650 -key root_ca.key -out root_ca.crt
```
Generate the client key. The passphrase used was `mtls`.
```
openssl genrsa -out client.key 2048
```
Generate a certificate signing request for the client certificate.
```
openssl req -new -key client.key -out client.csr
```
Sign the client certificate using the root CA to generate the client certificate:
```
openssl x509 \
  -req \
  -days 3650 \
  -set_serial 01 \
  -CA root_ca.crt \
  -CAkey root_ca.key \
  -in client.csr \
  -out client.crt
```