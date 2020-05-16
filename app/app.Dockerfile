FROM ubuntu:20.04
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir /app
WORKDIR /app
ADD ./app_files/requirements.txt /app

RUN apt-get -yqq update \
    && apt-get install -yqq \
        python3 \
        python3-dev \
        python3-pip \
        libpq-dev \
        nginx\
        curl\
        net-tools\
    && apt-get clean \
    && apt-get autoremove
RUN pip3 install -r requirements.txt

ADD market_nginx_conf /etc/nginx/sites-enabled/
ADD ./app_files/ /app

ENTRYPOINT ["bash", "start_project.sh"]
CMD ["python3", "/app/market/manage.py", "runserver", "docker.django:5000"]
