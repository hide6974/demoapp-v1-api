FROM ruby:2.7.1-alpine

ARG WORKDIR
ARG CONTAINER_PORT
ARG API_URL

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL}

# ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git" \
#     DEV_PACKAGES="build-base curl-dev" \
#     HOME=/${WORKDIR} \
#     LANG=C.UTF-8 \
#     TZ=Asia/Tokyo

# ENV check
RUN echo ${HOME}
RUN echo ${CONTAINER_PORT}
RUN echo ${API_URL}

WORKDIR ${HOME}

# 追加
COPY package*.json ./
RUN yarn install

COPY . ./

RUN yarn run build
# ここまで

EXPOSE ${CONTAINER_PORT}

# # ENV test（このRUN命令は確認のためなので無くても良い）
# RUN echo ${HOME}

# WORKDIR ${HOME}

# COPY Gemfile* ./

# RUN apk update && \
#     apk upgrade && \
#     apk add --no-cache ${RUNTIME_PACKAGES} && \
#     apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
#     bundle install -j4 && \
#     apk del build-dependencies

# COPY . .

# CMD ["rails", "server", "-b", "0.0.0.0"]
