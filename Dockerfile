#FROM ubuntu
FROM python:3.11.9-slim-bullseye

# Prepare environment
RUN apt-get update && \
apt-get install -y --no-install-recommends \
gcc \
libzip4 \
libzip-dev \
gfortran

# Install relevant python packages
RUN pip install numpy==1.24.2
RUN pip install scipy==1.10.1
RUN pip install pandas==2.1.0
RUN pip install pytz==2023.3
RUN pip install scikit-digital-health==0.11.5
RUN pip install openmovement==0.0.1
RUN pip install pyarrow==14.0.1
RUN pip install EntropyHub==0.2
RUN pip install antropy==0.1.6
# RUN pip install setuptools

# Grab code
RUN mkdir /code
COPY ./hbcd_motion_postproc/run.py /code
COPY ./hbcd_motion_postproc/base.py /code
COPY ./hbcd_motion_postproc/utils.py /code
COPY ./hbcd_motion_postproc/axivity.py /code
COPY ./hbcd_motion_postproc/my_parser.py /code
COPY ./hbcd_motion_postproc/cwa_metadata.py /code
COPY ./hbcd_motion_postproc/ax6_postproc.py /code
COPY ./hbcd_motion_postproc/pa_calc_mighty_tot.py /code

# Set permissions - needed?
RUN chmod 555 -R /code

# Add code dir to path
ENV PATH="${PATH}:/code"
RUN pipeline_name=axivity_postproc && cp /code/run.py /code/$pipeline_name

ENTRYPOINT ["axivity_postproc"]
