FROM centos:centos7
ADD ltb-project.repo /etc/yum.repos.d/ltb-project.repo
ADD config-dest.ldif /tmp
ADD config-source.ldif /tmp
ADD data-dest.ldif /tmp
ADD data-source.ldif /tmp
ADD slapd-dest-cli.conf /tmp
ADD slapd-source-cli.conf /tmp
RUN \
    yum update -y && \
    rpm --import https://ltb-project.org/lib/RPM-GPG-KEY-LTB-project && \
    yum install -y openldap-ltb openldap-ltb-contrib-overlays openldap-ltb-ppm && \
    source ~/.bash_profile && \
    cp /usr/local/openldap/sbin/slapd-cli /usr/local/openldap/sbin/slapd-source-cli && \
    cp /usr/local/openldap/sbin/slapd-cli /usr/local/openldap/sbin/slapd-dest-cli && \
    cp /tmp/slapd-dest-cli.conf  /usr/local/openldap/etc/openldap && \
    cp /tmp/slapd-source-cli.conf /usr/local/openldap/etc/openldap && \
    chown -R ldap.ldap /usr/local/openldap/etc/openldap/slapd-dest-cli.conf && \
    chown -R ldap.ldap /usr/local/openldap/etc/openldap/slapd-source-cli.conf && \
    mkdir /usr/local/openldap/etc/openldap/source-slapd.d && \
    mkdir /usr/local/openldap/var/openldap-data-source && \
    mkdir /usr/local/openldap/etc/openldap/dest-slapd.d && \
    mkdir /usr/local/openldap/var/openldap-data-dest && \
    slapadd -n0 -F /usr/local/openldap/etc/openldap/dest-slapd.d -l /tmp/config-dest.ldif && \
    slapadd -n1 -F /usr/local/openldap/etc/openldap/dest-slapd.d -l /tmp/data-dest.ldif && \
    slapadd -n0 -F /usr/local/openldap/etc/openldap/source-slapd.d -l /tmp/config-source.ldif && \
    slapadd -n1 -F /usr/local/openldap/etc/openldap/source-slapd.d -l /tmp/data-source.ldif && \
    chown -R ldap.ldap /usr/local/openldap/etc/openldap/dest-slapd.d && \
    chown -R ldap.ldap /usr/local/openldap/var/openldap-data-dest && \
    chown -R ldap.ldap /usr/local/openldap/etc/openldap/source-slapd.d && \
    chown -R ldap.ldap /usr/local/openldap/var/openldap-data-source

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
