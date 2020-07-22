FROM python:3.7 AS local

WORKDIR /app/local-dev
COPY requirements.txt ./

RUN apt-get update
RUN apt-get install vim -y
RUN apt-get install zsh -y
RUN apt-get install git -y
RUN pip3 install -U -r requirements.txt
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN echo 'set exrc' > ~/.vimrc

ENTRYPOINT ["tail", "-f", "/dev/null"]
