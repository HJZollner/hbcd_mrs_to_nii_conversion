#Python base image
FROM debian:stable-20230109-slim

RUN apt update && apt upgrade
RUN apt install wget build-essential libncursesw5-dev -y
RUN wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
RUN tar xzf Python-3.9.1.tgz
RUN cd Python-3.9.1
RUN . /configure --enable-optimizations
RUN make -j 2
RUN make alt install

# Prepare environment
RUN python3 -m pip install numpy
RUN python3 -m pip install nibabel==3.2.2
RUN python3 -m pip install matplotlib==3.5.1

RUN apt-get -y install curl
RUN apt install dcmtk


#Input some test data that we can use
RUN mkdir /data
#COPY tpl-MNI152NLin2009cAsym_res-01_T1w.nii.gz /data/t1.nii.gz
#COPY tpl-MNI152NLin2009cAsym_res-01_T2w.nii.gz /data/t2.nii.gz


#load the python script and tell docker to run that script
#when someone tries to execute the container
RUN mkdir /code
#COPY run.py /code/run.py
ENTRYPOINT ["python3"]

RUN chmod 555 -R /code /data
