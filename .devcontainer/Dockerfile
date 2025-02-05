FROM aliro-scheduler AS aliro-scheduler-dev

USER root

RUN apt-get install -y \ 
    sudo mc git curl wget \
    maven

RUN echo "cadabra ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/cadabra \
    chmod 0440 /etc/sudoers.d/cadabra


RUN mkdir -p /home/cadabra/.m2 && chown cadabra:cadabra /home/cadabra/.m2

USER cadabra