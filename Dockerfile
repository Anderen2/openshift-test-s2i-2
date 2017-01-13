# This image provides an environment for building and running Go applications.

FROM openshift/base-centos7

MAINTAINER None

EXPOSE 80 443

LABEL io.k8s.description="Platform for serving web sites using Apache" \
      io.k8s.display-name="Apache Static Webserv" \
      io.openshift.expose-services="80:http,443:https" \
      io.openshift.tags="builder,httpd,apache,apache2"

# Install Caddy
#RUN (curl -L https://github.com/mholt/caddy/releases/download/v0.8.2/caddy_linux_amd64.tar.gz | \
#        tar -zx -C /usr/local/bin) && \
#    setcap cap_net_bind_service=+ep /usr/local/bin/caddy
RUN yum install httpd -y
RUN setcap cap_net_bind_service=+ep /usr/sbin/httpd
RUN sed -ie 's/Listen\ 80/Listen\ 8080/g' /etc/httpd/conf/httpd.conf
RUN echo "Default source." > /var/www/html/index.html
RUN chmod a+rwx /run/httpd
RUN chmod a+rwx /etc/httpd/logs
RUN chmod a+rwx /var/www/html/

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/ $STI_SCRIPTS_PATH

USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage
