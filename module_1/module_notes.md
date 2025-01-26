# Module 1

## Docker and SQL

### Docker Intro

https://docs.docker.com/get-started/
https://hub.docker.com/

- image
- container
- Dockerfile

```sh
docker ps
```

```sh
// install cli tool for postgesql management
pip install pgcli

// run cli tool for postgesql management
pgcli -h localhost -p 5432 -u root -d ny_taxi

// show a list of the tables in DB
\dt
```

```sh
// Docker hello-world
docker run hello-world

// run container in interactive mode
docker run -it ubuntu bash
docker run -it python:3.9

// run container in interactive shell mode
docker run -it --entrypoint=bash python:3.9

// build container on Dockerfile
docker build -t test:pandas .

// run container
docker run -it test:pandas
docker run -it test:pandas 2021-10-11
```

```sh
// template for running postgesql via docker
docker run -it \
    -e POSTGRES_USER=<USER> \
    -e POSTGRES_PASSWORD=<PASS> \
    -e POSTGRES_DB=<DB> \
    -v <LOCALHOST_FULL_PATH>:<CONTAINER_FULL_PATH> \
    -p <LOCALHOST_PORT>:5432 \
    postgres:13

// FULL_PATH_LOCALHOST = $(pwd)/<REL_PATH>
// CONTAINER_FULL_PATH = /var/lib/postgresql/data

// example
docker run -it \
    -e POSTGRES_USER="postgres" \
    -e POSTGRES_PASSWORD="postgres" \
    -e POSTGRES_DB="postgres" \
    -v $(pwd)/postgres_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:13
```

### Ingesting NY Taxi Data to Postgres

- download green taxi data
- insert data in postgresql DB
- write some sql-queries

### Connecting to Postgres with Jupyter and Pandas

```sh
pip install psycopg2-binary
pip install sqlalchemy
```

```python
from sqlalchemy import create_engine
import pandas as pd

engine = create_engine('postgresql://postgres:postgres@localhost:5432/postgres')

engine.connect()

QUERY = """
SELECT 1 AS result;
"""

# pd.read_sql(query, con)
pd.read_sql(QUERY, con=engine)
```

### Connecting pgAdmin and Postgres

```sh
// example
docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="admin" \
    -p 8080:80 \
    dpage/pgadmin4
```

```sh
docker network create [OPTIONS] NETWORK

// example
docker network create pg-network
```

```sh
// example
docker run -it \
    -e POSTGRES_USER="postgres" \
    -e POSTGRES_PASSWORD="postgres" \
    -e POSTGRES_DB="postgres" \
    -v $(pwd)/postgres_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    --network=pg-network \
    --name pg-database \
    postgres:13

// example
docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="admin" \
    -p 8080:80 \
    --network=pg-network \
    dpage/pgadmin4

// In pgAdmin host will be "pg-database"!
```

### Dockerizing the Ingestion Script

```sh
jupyter nbconvert --to=script
```

### Running Postgres and pgAdmin with Docker-Compose

- docker-compose.yaml

```sh
docker compose up

// CTRL+C
docker compose down

//detauch mode
docker compose up -d
```

Question: How to configure volume for pgAdmin?


### SQL Refreshser

TBD

## Terraform and GCP

- IaC
- Local app + providers + Managed Services / Cloud

```sh
terraform init
terraform plan
terraform applay
terraform destroy
```

