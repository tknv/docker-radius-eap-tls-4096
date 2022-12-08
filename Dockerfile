FROM alpine:3.8

RUN apk add --no-cache freeradius freeradius-eap openssl

COPY radiusd.conf clients.conf /etc/raddb/
COPY eap /etc/raddb/mods-available
COPY site /etc/raddb/sites-available

RUN rm /etc/raddb/sites-enabled/* && \
    rm -rf /etc/raddb/certs && \
    ln -s /etc/raddb/sites-available/site /etc/raddb/sites-enabled/site && \
    mkdir /tmp/radiusd && \
    chown radius:radius /tmp/radiusd

COPY server.crt server.key ca.crt dh.pem /etc/raddb/certs/
RUN chown radius:radius /etc/raddb/certs/* \
    && chmod 400 /etc/raddb/certs/*

RUN chgrp -R radius /etc/raddb/

EXPOSE 1812/udp
USER radius

ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-X", "-f"]
