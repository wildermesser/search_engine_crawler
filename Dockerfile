FROM python:3.5.1
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY crawler /
ENV MONGO=mongodb
ENV MONGO_PORT=27017
ENV RMQ_HOST=rabbitmq
ENV RMQ_QUEUE=crawler
ENV RMQ_USERNAME=crawler
CMD [ "python", "crawler.py" ]
