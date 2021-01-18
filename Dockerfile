FROM composer:2.0.2 as composer

FROM docker/compose:alpine-1.26.2 AS docker-compose

FROM alpine:3.13.2

COPY --from=docker-compose /usr/local/bin/docker /usr/local/bin/docker

RUN apk add --no-cache \
	g++==10.2.1_pre1-r3 \
	gcc==10.2.1_pre1-r3 \
	curl==7.77.0-r0 \
	git==2.30.2-r0 \
	make==4.3-r0 \
	musl-dev==1.2.2-r0 \
	neovim==0.4.4-r0 \
	rabbitmq-c-dev==0.10.0-r1 \
 && nvim --version

# PHP

ARG PHP_VERSION=7.4.19-r0

RUN apk add --no-cache \
        php7==${PHP_VERSION} \
        php7-ctype==${PHP_VERSION} \
        php7-curl==${PHP_VERSION} \
        php7-dev==${PHP_VERSION} \
        php7-dom==${PHP_VERSION} \ 
        php7-iconv==${PHP_VERSION} \
        php7-intl==${PHP_VERSION} \
        php7-json==${PHP_VERSION} \
        php7-mbstring==${PHP_VERSION} \
        php7-openssl==${PHP_VERSION} \
        php7-pdo==${PHP_VERSION} \
        php7-pear==${PHP_VERSION} \
        php7-phar==${PHP_VERSION} \
        php7-simplexml==${PHP_VERSION} \
        php7-tokenizer==${PHP_VERSION} \
        php7-xml==${PHP_VERSION} \
        php7-xmlwriter==${PHP_VERSION}

RUN pecl install -f \
        mongodb-1.9.0 \
 && echo "extension=mongodb.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` \
 && (php -m | grep mongodb)

RUN pecl install -f \
        amqp-1.10.2 \
 && echo "extension=amqp.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` \
 && (php -m | grep amqp) 

RUN pecl install -f \
        xdebug-3.0.3 \
 && echo "zend_extension=/usr/lib/php7/modules/xdebug.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` \
 && (php -m | grep xdebug) 

ENV XDEBUG_MODE coverage

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV COMPOSER_HOME /home/.composer
ENV PATH /home/.composer/vendor/bin:$PATH
ENV PATH=./vendor/bin:$PATH

# RUBY

RUN apk add --no-cache \
        ruby-dev==2.7.3-r0 \
        ruby-bundler==2.2.2-r0 \
 && ruby --version

COPY ./Gemfile ./Gemfile
RUN bundle

# PYTHON

RUN apk add --no-cache \
        py3-pip==20.3.4-r0 \
        python3-dev==3.8.10-r0 \
 && python3 --version

COPY ./requirements.txt ./requirements.txt
RUN pip3 install -r requirements.txt

# NODEJS

ARG NODE_VERSION=14.16.1-r1

RUN apk add --no-cache \
        nodejs==${NODE_VERSION} \
        npm==${NODE_VERSION} \
 && node --version  \
 && npm install -g neovim

ENV PATH=./node_modules/.bin:$PATH

RUN adduser user \
        --uid 1000 \
        --home /home \
        --disabled-password \
 && addgroup docker \
 && addgroup user docker

USER 0
RUN chown user /home -R
USER 1000

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

COPY ./init.vim /home/.config/nvim/init.vim
COPY ./test.vim /home/.config/nvim/test.vim
COPY ./ftplugin /home/.config/nvim/ftplugin
COPY ./UltiSnips /home/.config/nvim/UltiSnips

RUN nvim --headless +'PlugInstall' +qall \
 && nvim --headless +'UpdateRemotePlugins' +qall

# Python 3.7+ compatibility
# RUN sed -i.bu 's/async=True/**{"async": True}/' ~/.vim/plugged/nvim-completion-manager/pythonx/cm.py \
#  && sed -i.bu 's/async=True/**{"async": True}/' ~/.vim/plugged/nvim-completion-manager/pythonx/cm_core.py

USER 0
RUN chown user /home -R
USER 1000

ENV NVIM_LISTEN_ADDRESS /tmp/nvim.sock

CMD ["nvim"]

WORKDIR /code
