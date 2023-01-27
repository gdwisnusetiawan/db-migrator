# 🕊 DB Migrator

A simple tool to migrate a service database. 
DB Migrator supports YAML or OS Env config type.
This tool will be used for the McEasy Platform service template.
Make sure you have the same service configuration as the service template.
## How to use
1. Build/Pull the DB Migrator image. ([Installation](#installation))
1. Run the image to the container. ([Setup](#setup-service-template))
1. Run the available DB Migrator operations from the container. ([Operations](#operations))
## Installation
Make sure you have a Docker & Git installed on your machine.

Clone the repository

```bash
# Via HTTPS
git clone https://github.com/mceasy-id/db-migrator.git

# or Via SSH
git clone git@github.com:mceasy-id/db-migrator.git
```

Go to the db-migrator directory
```bash
cd db-migrator
```

Build the Docker image
```bash
docker build -t hub.mceasy.com/db-migrator:v1.0 .
```

    
## Setup (Service Template)
Run the ```docker compose up``` command inside the service template to automatically setup the Postgres & DB Migrator container and ready to execute available operations.

## Setup (OS Env)

If you want to use the OS Env as the configuration, you have to manually run the image with env (```CONFIG_TYPE```,```PG_HOST```,```PG_PORT```,```PG_USER```,```PG_PASSWORD```,```PG_DBNAME```).
You also have to volume the ```schema.py``` file & ```versions``` folder to the container. 
```bash
docker run --name db-migrator \ 
-e CONFIG_TYPE=env \
-e PG_HOST=host \
-e PG_PORT=port \
-e PG_USER=user \
-e PG_PASSWORD=password \
-e PG_DBNAME=dbname \
-v {your project migration version folder path}:/app/alembic/versions
-v {your project migration schema.py path}:/app/schema.py
-it -d migrator
```
## Operations
- Create a Revision
 
```bash
docker exec db-migrator alembic revision --autogenerate -m "{custom message}"
```

- Update the database
 
```bash
docker exec db-migrator alembic update head
```

- Downgrade the database
 
```bash
docker exec db-migrator alembic downgrade -1
```
## Optimizations

- [ ] Handle multiple kind of databases (mysql, mongodb, etc).

