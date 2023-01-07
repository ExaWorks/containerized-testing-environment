FROM fluxrm/flux-sched:latest

ARG PYTHON_VERSION=3.7

# configuration:
#   https://flux-framework.readthedocs.io/en/latest/adminguide.html#configuring-the-flux-system-instance
#   https://flux-framework.readthedocs.io/projects/flux-core/en/latest/man5/flux-config-bootstrap.html
RUN sudo mkdir -p /etc/flux/system && \
    flux broker sudo -u fluxuser flux keygen /tmp/curve.cert && \
    sudo mv /tmp/curve.cert /etc/flux/system/

RUN sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev  \
    libnss3-dev libssl-dev libreadline-dev libffi-dev

COPY scripts/install-python.sh /home/fluxuser/
RUN sudo /home/fluxuser/install-python.sh "${PYTHON_VERSION}" "alternative" && \
    pip${PYTHON_VERSION} install --upgrade pip && \
    pip${PYTHON_VERSION} install cffi pyyaml git+https://github.com/ExaWorks/psij-python.git

USER fluxuser
WORKDIR /home/fluxuser/workdir/
COPY --chown=fluxuser:fluxuser psij/flux/hello-flux-container.py ./
