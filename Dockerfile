FROM lambci/lambda:build-python2.7

# Create deploy directory
WORKDIR /deploy
ENV WORKDIR /deploy

# Copy source
COPY . .

ENV TEMPLATE_OUTPUT_BUCKET cf-templates-dyvdnyma9kxw-ap-east-1
ENV DIST_OUTPUT_BUCKET slsimagehandler
ENV VERSION 3.1

RUN rpm --rebuilddb
# RUN yum install yum-utils -y
RUN yum -y install epel-release 
# RUN yum-config-manager --enable epel
# RUN yum update -y
RUN yum install --enablerepo=epel  wget libpng-devel libcurl-devel libjpeg-devel -y
#alias sudo='sudo env PATH=$PATH'
RUN pip install setuptools==39.0.1
RUN pip install virtualenv==15.2.0

RUN git clone https://github.com/jamesshen-svt/serverless-image-handler.git

RUN chmod +x serverless-image-handler/deployment/run-unit-tests.sh

RUN cd serverless-image-handler/deployment && \
    ./build-s3-dist.sh $DIST_OUTPUT_BUCKET $VERSION