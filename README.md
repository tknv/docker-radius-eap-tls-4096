# EAP TLS authentication

This helps quick setup EAP TLS for testing WPA2-Enterprise EAP TLS and WPA3-Enterprise EAP TLS (GCMP256).  
[FreeRadius](https://github.com/FreeRADIUS/freeradius-server) service it.

## Quick start

```bash
git clone https://github.com/tknv/docker-radius-eap-tls.git EAP-TLS_FreeRadius
cd EAP-TLS_FreeRadius
docker-compose up
```

Install Root CA and client cert by double click(usually) `pc.p12` and `ca.crt` in EAP-TLS_FreeRadius directory.

## Usage

* Radius is listening on port 1812 UDP.
* A secret for Radius server connection is `symbol123`
    * It usually set it at Access Point.
* A password for all private key is `symbol`
    * It will be asked when install client certificate `pc.p12`

### Install client cert and CA to client machine/device

#### Windows

Install cert and CA by double click `pc.p12` then double click `ca.crt`. And goto Control Panel > All Control Panel Items > Network and Sharing Center > Manually connect or Network.  
**Network name** should be SSID (if use EAP TLS auth for wireless client). **Security type** `WPA2-Enterprise` even want to test `WPA3-Enterprise`. Later can change it to `WPA3-Enterprise`.   

**WPA3-Enterprise allowed only EAP-TLS and PMF mandatory.**  
Thus, must select `Microsoft: Smart Card or other certification` at Choose a network authentication method:.  
At Setting tick belows;

* Use a certificate on this computer
* Use simple certificate selection(Recommended)
* Verify the server's identity by validating the certificate
* Trusted Root Certification Authorities
    * AWASLab  "which installed at previously as ca.crt"
    * pc  "which installed at previously as pc.p12"

### Linux

#### WPA3-Enterprise (GCMP256 EAP TLS)

`sudo wpa_supplicant -dd -c ./wpa3_supplicant.conf -i wlo1`

wlo1 is wireless interface. `ssid` is vary, change to AP's. 

Need to test. My current machine does not support it yet.

```bash
Successfully initialized wpa_supplicant
Line 10: invalid key_mgmt 'WPA-EAP-SUITE-B-192'
Line 10: no key_mgmt values configured.
Line 10: failed to parse key_mgmt 'WPA-EAP-SUITE-B-192'.
Line 23: failed to parse network block.
Failed to read or parse configuration '/home/tknv/src/docker-radius-eap-tls/./wpa3_supplicant.conf'.
```

#### WPA2-Enterprise (EAP TLS)

`sudo wpa_supplicant -dd -c ./wpa2_supplicant.conf -i wlo1`

wlo1 is wireless interface. `ssid` is vary, change to AP's. 

### Run EAP TLS auth service

```bash
git clone https://github.com/tknv/docker-radius-eap-tls.git
cd docker-radius-eap-tls
docker-compose up
```

## Configuration

No configuration at all.

## See also

[easy-rsa](https://github.com/OpenVPN/easy-rsa/) can quickly generate your certificates and keys.

This docker-radius-eap-tls is forked from  [evansgp/docker-radius-eap-tls](https://github.com/evansgp/docker-radius-eap-tls).

## WARNING

This is for lab use only. **Not secure at all.**
