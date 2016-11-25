FROM alpine:3.3

RUN apk add --no-cache python py-pip py-setuptools git ca-certificates
RUN pip install python-dateutil python-magic

RUN git clone --depth=1 https://github.com/s3tools/s3cmd.git /opt/s3cmd \
 && rm -rf /opt/s3cmd/.git \
 && ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

WORKDIR /opt

ADD ./files/s3cfg /root/.s3cfg
ADD ./files/main.sh /opt/main.sh

# Main entrypoint script
RUN chmod u+x /opt/main.sh

# Folders for s3cmd optionations
RUN mkdir /opt/src
RUN mkdir /opt/dest

WORKDIR /
ENTRYPOINT ["/opt/main.sh"]
CMD [""]
