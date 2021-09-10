FROM arm64v8/ubuntu

USER root

ENV LANG=en_US.UTF-8
ENV TZ=:/etc/localtime
ENV PATH=/var/lang/bin:/usr/local/bin:/usr/bin/:/bin:/opt/bin
ENV LD_LIBRARY_PATH=/var/lang/lib:/lib64:/usr/lib64:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib
ENV LAMBDA_TASK_ROOT=/var/task
ENV LAMBDA_RUNTIME_DIR=/var/runtime

ARG FUNCDIR=/var/task
WORKDIR ${FUNCDIR}
RUN mkdir -p ${FUNCDIR}

COPY bin/tar.sh /bin/tar2
RUN mkdir -p /opt/bin && \
    mv /bin/tar /opt/bin/ && \
    mv /bin/tar2 /bin/tar && \
    chmod 777 /bin/tar

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install binutils cmake autoconf libtool python3 python3-pip && \
    pip3 install awslambdaric

COPY app/hello.py ${FUNCDIR}
COPY app/lambda-entrypoint.sh /lambda-entrypoint.sh
COPY bin/aws-lambda-rie /usr/local/bin/aws-lambda-rie
ENTRYPOINT ["/lambda-entrypoint.sh"]
CMD ["hello.handler"]
