import dlt
import duckdb


pipeline = dlt.pipeline(
    pipeline_name="ny_taxi_pipeline",
    destination="duckdb",
    dataset_name="ny_taxi_data"
)

conn = duckdb.connect(f"{pipeline.pipeline_name}.duckdb")

conn.sql(f"SET search_path = '{pipeline.dataset_name}'")

df = conn.sql("DESCRIBE").df()

print(df)

