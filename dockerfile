FROM ubuntu
MAINTAINER Mansur Ul Hasan <mansurali901@gmail.com>
RUN apt-get update -y
RUN apt-get install openssh-server -y
RUN mkdir /var/run/sshd
RUN echo 'root:Password1' |chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#SSH login Fix Otherwise user is kicked off after Login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
####### Setting up JAVA #########

##RUN echo "Downloading JAVA JDK 1.8 from Local repository ########
RUN wget https://www.dropbox.com/s/dwsqw6gofynaf5e/jdk1.8.0_91.tar?dl=0
RUN mv jdk1.8.0_91.tar?dl=0 jdk1.8.0_91.tar

##RUN echo "Installing JAVA JDK 1.8"
RUN mkdir -p /usr/java
RUN mv jdk1.8.0_91.tar /usr/java

##RUN of /usr/java
RUN tar xvf /usr/java/jdk1.8.0_91.tar -C /usr/java/
RUN ln -s /usr/java/jdk1.8.0_91 /usr/java/latest

##echo "Creating links of binaries"
RUN ln -s /usr/java/latest/bin/java /usr/bin/java
RUN ln -s /usr/java/latest/bin/javac /usr/bin/javac
RUN ln -s /usr/java/latest/bin/javah /usr/bin/javah
RUN ln -s /usr/java/latest/bin/javap /usr/bin/javap
RUN ln -s /usr/java/latest/bin/javadoc /usr/bin/javadoc
RUN ln -s /usr/java/latest/bin/javaws /usr/bin/javaws
#echo "Checking JAVA version"
RUN java -version

