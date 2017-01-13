# This image provides an environment for building and running Go applications.

FROM openshift/base-centos7

MAINTAINER SoftwareCollections.org <sclorg@redhat.com>

EXPOSE 80 443

ENV CADDY_VERSION=0.8

LABEL io.k8s.description="Platform for serving web sites using Caddy" \
      io.k8s.display-name="Apache Static Webserv" \
      io.openshift.expose-services="80:http,443:https" \
      io.openshift.tags="builder,httpd,apache,apache2"

# Install Caddy
#RUN (curl -L https://github.com/mholt/caddy/releases/download/v0.8.2/caddy_linux_amd64.tar.gz | \
#        tar -zx -C /usr/local/bin) && \
#    setcap cap_net_bind_service=+ep /usr/local/bin/caddy
yum install httpd -y
setcap cap_net_bind_service=+ep /usr/bin/httpd
RUN sed -ie 's/Listen\ 80/Listen\ 8080/g' /etc/httpd/conf/httpd.conf
RUN echo "Default source." > /var/www/html/index.html
RUN chmod a+rwx /run/httpd
RUN chmod a+rwx /etc/httpd/logs

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/ $STI_SCRIPTS_PATH

USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage
