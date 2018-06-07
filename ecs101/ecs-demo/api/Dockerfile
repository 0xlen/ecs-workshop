FROM python:3-alpine
MAINTAINER yangxinc@amazon.com
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt

EXPOSE 8000

ENTRYPOINT ["python"]
CMD ["app.py"]
