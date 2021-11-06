FROM ubuntu:18.04

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

RUN apt update && apt install -y build-essential unzip vim git curl wget zip

RUN apt-get update &&\
	apt-get upgrade -y &&\
    apt-get install -y  software-properties-common

# JS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@latest

EXPOSE 8080
EXPOSE 5000
EXPOSE 9000


RUN useradd -ms /bin/bash oleh203
RUN adduser oleh203 sudo

USER oleh203
WORKDIR /home/oleh203/
RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "/home/oleh203/.sdkman/bin/sdkman-init.sh"
RUN bash -c "source /home/oleh203/.sdkman/bin/sdkman-init.sh && sdk install java 11.0.11.hs-adpt"
RUN bash -c "source /home/oleh203/.sdkman/bin/sdkman-init.sh && sdk install gradle 7.2"
RUN bash -c "source /home/oleh203/.sdkman/bin/sdkman-init.sh && sdk install kotlin 1.5.31"

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN git clone https://github.com/kprzystalski/vim && cp vim/.vimrc /home/oleh203/

RUN mkdir projekt
WORKDIR /home/oleh203/projekt/