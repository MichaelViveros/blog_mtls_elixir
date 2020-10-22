# Certs

| File | Part 1 or 2 | Description | CN
| :------------- | :------------- | :------------- | :------------- |
| ca.crt | 1 | root CA | `Dummy Root CA`
| client.crt | 1 | client certificate | `dummy-mtls-client.com`
| server.crt | 2 | server certificate | `dummy-mtls-server.com`
| intermediate_ca.crt | 2 | intermediate CA | `Dummy Intermediate CA`
| client2.crt | 2 | client certificate signed by intermediate CA | `dummy-mtls-client-2.com`
| root_and_intermediate.crt | 2 | root CA + intermediate CA  | N/A

## Commands

I used https://github.com/square/certstrap to simplify creating the certificates. It didn't support specifying `pathlen` in the root CA though which is necessary to allow intermediate CAs under the root CA to sign certificates. So I used agy's fork of certstrap, see https://github.com/square/certstrap/pull/112.

```sh
certstrap="../certstrap_forked/bin/certstrap-dev-4f86a9bc-darwin-amd64"
./$certstrap init --common-name "Dummy Root CA" --path-length 1
./$certstrap request-cert --common-name dummy-mtls-client.com
./$certstrap sign dummy-mtls-client.com --CA "Dummy Root CA"
./$certstrap request-cert --common-name dummy-mtls-server.com
./$certstrap sign dummy-mtls-server.com --CA "Dummy Root CA"
./$certstrap request-cert --common-name "Dummy Intermediate CA"
./$certstrap sign "Dummy Intermediate CA" --CA "Dummy Root CA" --intermediate
./$certstrap request-cert --common-name dummy-mtls-client-2.com
./$certstrap sign dummy-mtls-client-2.com --CA "Dummy Intermediate CA"

cp out/Dummy_Root_CA.key certs/ca.key
cp out/Dummy_Root_CA.crt certs/ca.crt
cp out/dummy-mtls-client.com.key certs/client.key
cp out/dummy-mtls-client.com.crt certs/client.crt
cp out/dummy-mtls-server.com.key certs/server.key
cp out/dummy-mtls-server.com.crt certs/server.crt
cp out/Dummy_Intermediate_CA.key certs/intermediate_ca.key
cp out/Dummy_Intermediate_CA.crt certs/intermediate_ca.crt
cp out/dummy-mtls-client-2.com.key certs/client2.key
cp out/dummy-mtls-client-2.com.crt certs/client2.crt
```