import dlt


pipeline = dlt.pipeline(
    pipeline_name="ny_taxi_pipeline",
    destination="duckdb",
    dataset_name="ny_taxi_data"
)

df = pipeline.dataset(dataset_type="default").rides.df()
print(df)

