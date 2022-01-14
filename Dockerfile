FROM fluent/fluentd:latest
 
USER root
WORKDIR /home/fluent
 
RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
    && echo 'gem: --no-document' >> /etc/gemrc \
    && gem install fluent-plugin-secure-forward \
    && gem install fluent-plugin-record-reformer \
    && gem install fluent-plugin-gelf-hs \
    && gem install fluent-plugin-kubernetes_metadata_filter \
    && gem install fluent-plugin-rewrite-tag-filter \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
 
# Copy plugins
COPY plugins /fluentd/plugins/
 
# Environment variables
ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"
 
# For Kubernetes. Start Fluentd by user root
ENV FLUENT_UID="0"
 
# Run Fluentd
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
