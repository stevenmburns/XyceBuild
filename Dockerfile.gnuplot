FROM ubuntu:18.04 as gnuplot_image

RUN \
    apt-get update && apt-get install -yq gnuplot
