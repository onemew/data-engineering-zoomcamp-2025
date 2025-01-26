# Module 1 Homework: Docker & SQL

## Question 1. Understanding docker first run

Run a container in interactive mode with the desired version of Python.

```sh
docker run -it --entrypoint=bash python:3.12.8
```

In the container shell run `pip`.

```sh
pip --version
```

## Question 2. Understanding Docker networking and docker-compose

Run containers with PostgreSQL and pgAdmin on the same network via Docker Compose, and try to connect to the database via pgAdmin. And we find out that service name and `container_name` will both work as `hostname` for the db connection.

Run command in the directory with `docker-compose.yaml` (example is in current directory).

```sh
docker compose up
```

##  Prepare Postgres

### Upload taxi trip data to database

1. Build docker image with ingesting python script, requirements, and wget (use `Dockerfile` is in current directory).

```sh
docker build -t dezc2025_m1_data_upload:v001 .
```

2. Create docker network for the correct operation of the PostgreSQL container and data ingesting container.

```sh
docker network create pg-network
```

3. Create an environment variable with data URL for convenience.

```sh
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz"
```

4. Run PostgreSQL container.

```sh
docker run -it \
    -e POSTGRES_USER="postgres" \
    -e POSTGRES_PASSWORD="postgres" \
    -e POSTGRES_DB="postgres" \
    -v $(pwd)/postgres_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    --network=pg-network \
    --name pg-database \
    postgres:13
```

5. Run data ingesting container.

```sh
docker run -it \
    --network=pg-network \
    dezc2025_m1_data_upload:v001 \
    --user=postgres \
    --password=postgres \
    --host=pg-database \
    --port=5432 \
    --db=postgres \
    --table_name=trips \
    --url=${URL}
```

6. For uploading of zones dictionary use script `upload_zones.py`.

## Question 3—6

SQL-queries that help to ind answers in the file `questions_3-6.sql`.

## Terraform

## Question 7. Terraform Workflow


