# MtlsElixir

Template project for my mTLS Elixir blog. 

`mix.exs` includes a dependency for `HTTPoison`. 

`lib/mtls_elixir.ex` contains a base module that the blog builds on.

`certs/` includes some dummy certificates:
* `root_ca.crt` - root CA certificate, CN = "Dummy Root CA"
* `client.crt` - client certificate signed by root CA, CN = "dummy-mtls-client.com"