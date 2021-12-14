FROM ucsdets/scipy-ml-notebook:2021.3.1

LABEL maintainer="Javier Duarte <jduarte@ucsd.edu>"

USER root

# Install tcsh xorg-dev gfortran
RUN apt-get update -y
RUN apt-get install tcsh xorg-dev gfortran man -y

# Install nemo
RUN wget https://teuben.github.io/nemo/install_nemo
SHELL ["/bin/tcsh", "-c", "source install_nemo nemo=nemo"]

# Run env
RUN chmod +x nemo/nemo_start.sh

# Fix permissions
RUN fix-permissions /home/$NB_USER

USER $NB_USER
WORKDIR /home/$NB_USER

ENV USER=${NB_USER}

CMD ["nemo/nemo_start.sh && start-notebook.sh"]