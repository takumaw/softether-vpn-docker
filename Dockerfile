FROM buildpack-deps:stretch

RUN set -ex \
    && cd /opt \
    && curl -O https://jp.softether-download.com/files/softether/v4.27-9668-beta-2018.05.29-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.27-9668-beta-2018.05.29-linux-x64-64bit.tar.gz \
    && tar xvf softether-vpnserver-*.tar.gz \
    && rm -rf softether-vpnserver-*.tar.gz \
    && cd /opt/vpnserver \
    && make i_read_and_agree_the_license_agreement \
    && chmod 755 vpncmd vpnserver

WORKDIR /opt/vpnserver

ENV PATH /opt/vpnserver:$PATH

EXPOSE 443 992 5555 1194/udp
EXPOSE 500/udp 1701/udp 4500/udp

VOLUME /opt/vpnserver/chain_certs
VOLUME /opt/vpnserver/packet_log
VOLUME /opt/vpnserver/security_log
VOLUME /opt/vpnserver/server_log

CMD /opt/vpnserver/vpnserver start; sleep infinity
