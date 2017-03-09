FROM bioboxes/biobox-minimal-base

MAINTAINER Stefan Janssen, stefan.m.janssen@gmail.com

ENV PREFIX /CAMIARKQuikr-master/

COPY image/ /usr/local

RUN /usr/local/install.sh

ENV SCHEMA /usr/local/schema.yaml

ENV BIOBOX_EXEC execute_biobox.sh

ENV TASKFILE /usr/local/Taskfile
