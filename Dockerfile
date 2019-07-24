FROM lambci/lambda:build-python2.7

WORKDIR /tmp
ENV WORKDIR /tmp

COPY . .

RUN yum install yum-utils epel-release -y
RUN yum-config-manager --enable epel
RUN yum update -y
RUN yum install zip wget git libpng-devel libcurl-devel gcc python-devel libjpeg-devel -y
RUN pip install setuptools==39.0.1
RUN pip install virtualenv==15.2.0
