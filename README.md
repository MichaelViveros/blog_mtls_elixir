# MtlsElixir

Code for my mTLS Elixir blog.

## Certificates

Here are the commands used to generate the local dummy certificates in `/certs`.

Generate the local root CA key. The passphrase used was `mtls`.
```
openssl genrsa -des3 -out local_root_ca.key 4096
```
Generate a self-signed cert for the local root CA, CN=Local Root CA:
```
openssl req -new -x509 -days 3650 -key local_root_ca.key -out local_root_ca.crt
```
Generate the client key.
```
openssl genrsa -out client.key 2048
```
Generate a certificate signing request for the client certificate.
```
openssl req -new -key client.key -out client.csr
```
Sign the client certificate using the local root CA to generate the client certificate, CN=Local Client:
```
openssl x509 \
  -req \
  -days 3650 \
  -set_serial 01 \
  -CA local_root_ca.crt \
  -CAkey local_root_ca.key \
  -in client.csr \
  -out client.crt
```

To see test site's certs:
```
openssl s_client -connect server.cryptomix.com:443 -servername server.cryptomix.com
```

When making a request to https://server.cryptomix.com/secure/, a TLS connection will be established which includes server auth then the server will ask for the client cert. If you provide a client cert, the response will include info about the client cert. If you don't the response will indicate no client cert was provided.

To generate intermediate CA:
```bash
openssl genrsa -des3 -out intermediate_ca.key 4096
openssl req -new -key intermediate_ca.key -out intermediate_ca.csr
openssl x509 \
  -req \
  -days 365 \
  -set_serial 01 \
  -CA ca.crt \
  -CAkey ca.key \
  -in intermediate_ca.csr \
  -out intermediate_ca.crt
```