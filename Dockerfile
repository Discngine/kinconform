FROM centos

ENV PATH /opt/conda/bin:$PATH

COPY . /opt/kinconform

RUN curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh &&  \
/bin/bash miniconda.sh -b -p /opt/conda && \
/opt/conda/bin/conda clean -tipsy && \
/opt/conda/bin/conda config --set auto_activate_base false && \
/opt/conda/bin/conda env create -f /opt/kinconform/kinconform.yml && \
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
echo "conda activate kinconform" >> ~/.bashrc

RUN source ~/.bashrc
WORKDIR /opt/kinconform/biocma
RUN python setup.py build
RUN python setup.py install
WORKDIR /opt/kinconform



ENTRYPOINT [ "./kinconform" ]