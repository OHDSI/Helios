FROM solr:latest

RUN mkdir /opt/solr/contrib/dataimporthandler/lib
COPY ./postgresql-42.1.4.jar /opt/solr/contrib/dataimporthandler/lib/postgresql-42.1.4.jar
RUN mkdir /opt/solr/server/solr/vocab
COPY ./core.properties /opt/solr/server/solr/vocab/core.properties
RUN mkdir /opt/solr/server/solr/vocab/conf
COPY ./data-config.xml /opt/solr/server/solr/vocab/conf/data-config.xml
COPY ./solrconfig.xml /opt/solr/server/solr/vocab/conf/solrconfig.xml
COPY ./schema.xml /opt/solr/server/solr/vocab/conf/schema.xml
COPY ./stopwords.txt /opt/solr/server/solr/vocab/conf/stopwords.txt
COPY ./synonyms.txt /opt/solr/server/solr/vocab/conf/synonyms.txt
COPY ./protwords.txt /opt/solr/server/solr/vocab/conf/protwords.txt
COPY ./elevate.xml /opt/solr/server/solr/vocab/conf/elevate.xml
#RUN /usr/bin/curl http://localhost:8983/solr/vocab/dataimport?command=full-import
EXPOSE 8983
WORKDIR /opt/solr
