FROM python:3.6
RUN apt update && apt install -y netcat && rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY wait-for /
COPY crawler /
ENV MONGO=mongodb
ENV MONGO_PORT=27017
ENV RMQ_HOST=rabbitmq
ENV RMQ_QUEUE=crawler
ENV RMQ_USERNAME=crawler
ENV EXCLUDE_URLS='.*github.com'
CMD [ "python", "crawler.py", "https://vitkhab.github.io/search_engine_test_site/" ]
