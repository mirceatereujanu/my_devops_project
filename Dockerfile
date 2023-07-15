FROM python:3.6
MAINTAINER Mircea Tereujanu "mirceatereujanu@gmail.com" 
COPY app.py test.py /app/
WORKDIR /app
RUN pip install flask pytest flake8 # To download all the dependencies if applicable
CMD ["python", "app.py"]