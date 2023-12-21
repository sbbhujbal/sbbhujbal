import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node Amazon S3
AmazonS3_node1703098546880 = glueContext.create_dynamic_frame.from_options(
    format_options={
        "quoteChar": '"',
        "withHeader": True,
        "separator": ",",
        "multiline": False,
        "optimizePerformance": False,
    },
    connection_type="s3",
    format="csv",
    connection_options={"paths": ["s3://sbhujbal123/raw/"], "recurse": True},
    transformation_ctx="AmazonS3_node1703098546880",
)

# Script generated for node Change Schema
ChangeSchema_node1703099461870 = ApplyMapping.apply(
    frame=AmazonS3_node1703098546880,
    mappings=[
        ("Beverage_category", "string", "Beverage_category", "string"),
        ("Beverage", "string", "Beverage", "string"),
        ("Beverage_prep", "string", "Beverage_prep", "string"),
        ("Calories", "string", "Calories", "bigint"),
        ("`Total Fat (g)`", "string", "Total_Fat_g", "decimal"),
        ("`Trans Fat (g)`", "string", "Trans_Fat_g", "decimal"),
        ("`Saturated Fat (g)`", "string", "Saturated_Fat_g", "decimal"),
        ("`Sodium (mg)`", "string", "Sodium_mg", "decimal"),
        ("`Total Carbohydrates (g)`", "string", "Total_Carbohydrates_g", "bigint"),
        ("`Cholesterol (mg)`", "string", "Cholesterol_mg", "bigint"),
        ("`Dietary Fibre (g)`", "string", "Dietary_Fibre_g", "decimal"),
        ("`Sugars (g)`", "string", "Sugars_g", "bigint"),
        ("`Protein (g)`", "string", "Protein_g", "string"),
        ("`Vitamin A (% DV)`", "string", "Vitamin_A_perdv", "decimal"),
        ("`Vitamin C (% DV)`", "string", "Vitamin_C_perdv ", "decimal"),
        ("`Calcium (% DV)`", "string", "Calcium__perdv", "string"),
        ("`Iron (% DV)`", "string", "Iron_perdv", "decimal"),
        ("`Caffeine (mg)`", "string", "Caffeine_mg", "decimal"),
    ],
    transformation_ctx="ChangeSchema_node1703099461870",
)

# Script generated for node Amazon S3
AmazonS3_node1703098733075 = glueContext.getSink(
    path="s3://sbhujbal123/curated/",
    connection_type="s3",
    updateBehavior="LOG",
    partitionKeys=[],
    compression="snappy",
    enableUpdateCatalog=True,
    transformation_ctx="AmazonS3_node1703098733075",
)
AmazonS3_node1703098733075.setCatalogInfo(
    catalogDatabase="sundb", catalogTableName="sb_nutrition"
)
AmazonS3_node1703098733075.setFormat("glueparquet")
AmazonS3_node1703098733075.writeFrame(ChangeSchema_node1703099461870)
job.commit()
