# syntax=docker/dockerfile:1
#ABESIT DGX 
#FROM nvcr.io/nvidia/pytorch:22.11-py3 
# GLB DGX
#20.12-py3 

FROM python:3.8-slim-buster

#Upgrade pip
RUN /usr/local/bin/python -m pip install --upgrade pip

#https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d
#ENV TZ=Asia/Kolkata
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /Multi-Person-Face-Recognition

RUN apt update -y && apt install ffmpeg libsm6 libxext6 build-essential -y
RUN pip3 install boost cmake
RUN pip3 install --upgrade setuptools

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

#Gmail APIs
RUN pip3 install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib

COPY . .

CMD [ "python3", "-m" , "flask", "--app", "src/app", "run", "--host=0.0.0.0"]
