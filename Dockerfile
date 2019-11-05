FROM kennethreitz/pipenv:latest

# -- Install System Dependencies:
RUN apt-get update && apt-get install -y \
    build-essential \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libffi-dev \
    wget \
    libssl1.0-dev \
    nodejs-dev \
    node-gyp \
    npm \
    locales \
    locales-all \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Japanese Tokenizer: mecab-ipadic-neologd
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/neologd && \
    /tmp/neologd/bin/install-mecab-ipadic-neologd -n -u -y && \
    rm -rf /tmp/neologd
ENV MECAB_DICDIR="/usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd"

# Install Python Dependencies via Pipenv
WORKDIR /notebooks
COPY . /notebooks
RUN pipenv install --system --ignore-pipfile --deploy

# Setup JupyterLab Dependencies
RUN jupyter serverextension enable --py jupyterlab && \
    jupyter notebook --generate-config && \
    sed -i -e "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '0.0.0.0'/g" ~/.jupyter/jupyter_notebook_config.py && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter nbextension enable --py widgetsnbextension

EXPOSE 8888

ENTRYPOINT ["bash", "-lc"]

CMD ["jupyter lab --notebook-dir=/notebooks --no-browser --allow-root"]
