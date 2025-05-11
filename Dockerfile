FROM ubuntu:noble
WORKDIR /root
RUN cd /root
RUN apt update && apt install -y curl
RUN curl -O "https://dlcdn.apache.org/hadoop/common/hadoop-3.4.1/hadoop-3.4.1.tar.gz"
RUN curl -O "https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u442-b06/openlogic-openjdk-8u442-b06-linux-x64.tar.gz"
RUN tar -xvzf hadoop-3.4.1.tar.gz
RUN rm hadoop-3.4.1.tar.gz
RUN apt install -y unzip
RUN tar -xvzf openlogic-openjdk-8u442-b06-linux-x64.tar.gz
RUN rm openlogic-openjdk-8u442-b06-linux-x64.tar.gz
RUN apt install -y ssh
RUN mv openlogic-openjdk-8u442-b06-linux-x64 jdk
ENV JAVA_HOME='/root/jdk'
ENV HADOOP_HOME='/root/hadoop-3.4.1'
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV PATH=$PATH:$JAVA_HOME/bin
COPY ./core-site.xml /root/hadoop-3.4.1/etc/hadoop/core-site.xml
COPY ./core-site.xml /root/hadoop-3.4.1/etc/hadoop/hdfs-site.xml
RUN ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
COPY ./init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh
ENTRYPOINT ["/usr/local/bin/init.sh"]
