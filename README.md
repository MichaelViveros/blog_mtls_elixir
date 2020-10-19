# MtlsElixir

Template project for my mTLS Elixir blog. 

`mix.exs` includes a dependency for `HTTPoison`.  

`certs/` includes some dummy certificates:
* `local_root_ca.crt` - root CA certificate, CN = "Local Root CA"
* `client.crt` - client certificate signed by root CA, CN = "Local Client"