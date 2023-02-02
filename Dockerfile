#Python base image
FROM python:3.8.16-slim-bullseye

RUN apt update && apt upgrade
#RUN apt install wget build-essential libncursesw5-dev -y
#RUN wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
#RUN tar xzf Python-3.9.1.tgz
#RUN cd Python-3.9.1 && ./configure --enable-optimizations && make -j 2 && make alt install

# Prepare environment
#RUN python3 -m pip install numpy
#RUN python3 -m pip install nibabel==3.2.2
#RUN python3 -m pip install matplotlib==3.5.1

RUN apt update && apt upgrade
RUN apt-get -y install curl
RUN apt install dcmtk -y

#RUN curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg
RUN apt install conda

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
