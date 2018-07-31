FROM python:3.6
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY crawler /
ENV MONGO=mongodb
ENV MONGO_PORT=27017
ENV RMQ_HOST=rabbitmq
ENV RMQ_QUEUE=crawler
ENV RMQ_USERNAME=crawler
ENV EXCLUDE_URLS='.*github.com'
CMD [ "python", "crawler.py", "https://vitkhab.github.io/search_engine_test_site/" ]