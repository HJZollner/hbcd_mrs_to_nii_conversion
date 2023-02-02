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

# Installation for dcmtk
RUN apt update && apt upgrade
RUN apt-get -y install curl
RUN apt install dcmtk -y

# Installation for conda
RUN apt install gnupg -y
RUN curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
RUN install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg
RUN gpg --keyring /usr/share/keyrings/conda-archive-keyring.gpg --no-default-keyring --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" > /etc/apt/sources.list.d/conda.list
RUN apt update
RUN apt install conda -y
#ENV PATH=$CONDA_DIR/bin:$PATH
#RUN source /opt/conda/etc/profile.d/conda.sh

# Install spec2nii
RUN bash /opt/conda/etc/profile.d/conda.sh install -c conda-forge spec2nii=0.6.1

# Install FSL-MRS
RUN bash /opt/conda/etc/profile.d/conda.sh install -c conda-forge -c defaults -c https://fsl.fmrib.ox.ac.uk/fsldownloads/fslconda/public/ fsl_mrs=1.1.2

RUN unar

RUN mkdir /code
COPY spec2nii_HBCD_batch.sh /code/run.sh

ENTRYPOINT ["bash", "/code/run.sh"]

RUN chmod 555 -R /code
