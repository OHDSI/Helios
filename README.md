# Helios - ALPHA RELEASE
Docker image for creating and initializing a SOLR based text index for use in support of vocabulary search functionality.

The current state of this repository should allow for the creation of a Docker image with SOLR and configurations required to connect to a CDM Vocabulary schema.  Loading of the SOLR core must be done through the SOLR Administration interface.  Once the core is built the Helios branch (in development) of the WebAPI will be able to leverage SOLR as a micro-service, available for OHDSI clients through the WebAPI.

Helios was one of the Titans, son of Hyperion and Theia. He was the personification of the Sun. (https://www.greekmythology.com/Other_Gods/Helios/helios.html)

## How to configure
This repository includes the driver for Postgresql as well as instructions to copy it into the required location in the Docker image during the build.
Using a different driver for another database platform requires adding the driver.

The copying of the driver is executed in the Dockerfile:
```
COPY ./postgresql-42.1.4.jar /opt/solr/contrib/dataimporthandler/lib/postgresql-42.1.4.jar
```
Edit the data-config.xml file to update the dataSource node information including driver, url, user, and password attributes.
```xml
<dataSource driver="org.postgresql.Driver" url="jdbc:postgresql://YOUR_SERVER:5432/YOUR_DATABASE" user="USERNAME" password="PASSWORD"/>
```
The solrconfig.xml file needs to reference the required driver location.
```
<lib dir="${solr.install.dir:../../../..}/contrib/dataimporthandler/lib/" regex="postgresql-\d.*\.jar"/>
```
The name of the SOLR core that will be created is configured in the core.properties file.
The name of the core should coincide with the version identifier of the CDM Vocabulary to allow querying the proper vocabulary core to correspond with the version of the Vocabulary in use at the respective OHDSI site.  Synchronization of this with the WebAPI is still a work in progress.
```
name=vocab
```
## How to build
```
docker build -t ohdsi-solr .
```
## How to run
```
docker run --name ohdsi-solr -d -p 8983:8983 -t ohdsi-solr
```
## Integration with OHDSI/WebAPI
The HELIOS branch of the WebAPI project integrates with the docker image created by the code in this repository.  Once this functionality is tested and completed the HELIOS branch of WebAPI will be merged into master and included in an upcoming WebAPI release.  Proper configuration of the WebAPI will allow the SOLR docker image to be leveraged for vocabulary search in the WebAPI and through client applications such as ATLAS.
