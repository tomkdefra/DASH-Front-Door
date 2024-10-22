---
title: ""
permalink: /playbook/unitycatalog/
sidebar:
  - nav: "playbook"
---

# Unity Catalog {#uc}

Under construction. Read for general concepts, specifics might change.
```{r, echo = FALSE, out.width = '80%'}
knitr::include_graphics("images/underconstruction.jpg", dpi = NA)
```

Unity Catalog will be rolled out to workspaces over the coming months. 

## What is a Unity Catalog?

Databricks Unity Catalog is a unified governance layer for data and AI within the Databricks Data Intelligence Platform. With Unity Catalog we can seamlessly govern our structured and unstructured data, machine learning models, notebooks, dashboards and files. Data scientists, analysts and engineers can use Unity Catalog to securely discover, access and collaborate on trusted data and AI assets, leveraging AI to boost productivity and unlock the full potential of the lakehouse architecture. This unified approach to governance accelerates data and AI initiatives while simplifying regulatory compliance.  
  
In simpler terms. Unity Catalog makes it possible to have fine grained permissions for the datasets in the datalake, making it easier to build a lakehouse. 

## What is a lakehouse?

A data lakehouse is a data management architecture that combines the flexibility, cost-efficiency, and scale of data lakes with the data management and ACID transactions of data warehouses, enabling business intelligence (BI) and machine learning (ML) on all the same data.

## Evolution of the Lakehouse architecture

### Data Warehouse

Data warehouses store structured data. This is typically relational data sets from multiple source acting as a single source of "data truth" that can then be accessed by SQL and BI tools.

&#x25B2; Improving data standardization, quality, and consistency  
&#x25B2; Delivering enhanced business intelligence  
&#x25B2; Increasing the power and speed of data analytics and business intelligence workloads  
&#x25B2; Improving the overall decision-making process  
&#x25BC; Lack of data flexibility  
&#x25BC; No access to raw data  
&#x25BC; High implementation and maintenance costs  

### Data Lake

The lack of data flexibilty is limiting for data science workflows. Data lakes can handle both structured and unstructured data. This means data can be stored as an object in its raw form.

&#x25B2; Data consolidation  
&#x25B2; Data flexibility  
&#x25B2; Support for a wide variety of data science and machine learning use cases  
&#x25BC; Poor performance for business intelligence and data analytics use cases  
&#x25BC; Lack of data reliability and security

### Data Lakehouse

Lakehouses combine the main benefits of both the above architectures. You can think of this as creating a data warehouse on the datalake.

&#x25B2; Single data source for everyone
&#x25B2; All the pros of the above  
&#x25B2; None of the cons of the above

## Medallion Architecture

To manage data in a lakehouse where there is both raw and business ready data requires a data quality strategy. In Unity Catalog we will be implementing a medallion architecture. This is an intuitive way to separate data in layers of quality.

### Bronze

Bronze data is usually the raw data from a source. There may be minimal cleaning and transforms on data ingestion. All data so far in the DASH catalog would be considered Bronze data.

### Silver (Under construction)

Silver data has been cleaned up. It may have had some transform, aggregation, be only a part of the raw dataset or combined with others. There will be set file formats.

### Gold (Still to come)

Gold data is the business ready datasets, results of analysis/models.

## How will Unity Catalog change my workflow?

We are trying where possible to minimise disruption of introducing Unity Catalog. The main changes are outlined below. The current mounts will not be disconnected so there will be no requirement to change code immediately.
Knowledge of the next stage, introducing a sliver layer, and gold thereafter, may help you plan for these future changes.

### File path change

For working in Python and SQL in Databricks notebooks, or running code through the VSCode Databricks extension, the only change required will be to file paths. This is true for running R in a notebook as well but be aware of the restrictions below.  

The UC file path format:  

```{r, eval=FALSE}
path = "/Volumes/<Catalog>/<schema>/<volume>/<filestructure>/<filename.frz>"
```


Paths to the dbfs will change from:

``` {r, eval=F, echo=T}
path = "/dbfs/mnt/base/unrestricted/source_bluesky/dataset_aerial_phot...6200.tif"

```

to:

```{r, eval=FALSE}
path = "/Volumes/prd_dash_bronze/bluesky_unrestricted/aerial_photo...6200.tif"
```


### Lab Zones

A general Lab Zone will be available as a volume under the prd_dash_lab catalog. Users with write access will be able to create their own directory structures in this volume.  
When working with restricted data you may also require a Lab Zone set with the same permissions.  
Other Lab Zones with custom permissions can be created on request.

### Cluster restrictions

Currently, Unity Catalog will not run on shared R enabled clusters. To be able to run R, or an RStudio server, with Unity Catalog a single user cluster is required. Shared clusters can run Python/SQL.

### RStudio Server restrictions

When running RStudio Server on a cluster it will not have direct access to Unity Catalog. The Databricks API can be used to access files for which you have permission.

Example using httr package:

```{r, eval=FALSE}
library(httr)

uc_volume_get <- function(){
  
  # prepare the URL and headers
  url <- "{databricks_url} + {/api/2.0/fs/files} + {path to volume in UC}"
  headers <- add_headers('Authorization' = 'Bearer {MY_DATABRICKS_PAT_TOKEN}')
  
  
  # make the GET request
  response <- GET(url, headers)
  
  # Extract content from the response
  result <- content(response, "text")
  stop_for_status(response)
  
  writeLines(result, '~/downloads/filename.ext') # this downloads to disk 
  
  # Close the connection
  
  
  return(response)
  
}

uc_volume_get()
```



Example using Httr2:


```{r, eval=FALSE}
library(httr2)

workspace <- "https://adb-7422054397937474.14.azuredatabricks.net"
# Use correct workspace url
token <- 'dapid4b3d********************a687f9b'
# Please use your own token.
volume <- "/Volumes/prd_dash_bronze/<path-to-file>/filename.csv"

url <- paste(workspace, "/api/2.0/fs/files", volume, sep="")

api_response <- request(url) |>
  req_auth_bearer_token(token) |>
  req_perform() |>
  resp_body_string() |>
  readr::read_csv()

print(api_response)

write.csv(api_response, "data.csv")
```
Example with sparklyr:


```{r, eval=FALSE}
library(sparklyr)
library(dplyr)
library(dbplyr)

sc <- sparklyr::spark_connect(
  master     = Sys.getenv("DATABRICKS_HOST"),
  cluster_id = Sys.getenv("DATABRICKS_CLUSTER_ID"),
  token      = Sys.getenv("DATABRICKS_TOKEN"),
  method     = "databricks_connect",
  envname    = "r-sparklyr-databricks-14.3"
)

path = "/Volumes/catalog/schema/volume/subdirectory/my_geojson.geojson"

df <- spark_read_json(sc, path, options = list(multiLine = "true"))

# Show the result
print(class(df))
print(df)
```

## Permissions

The ability to access or write to volumes will be set by group membership. 
Requests for permission changes will be sent to the dashplatformsupport@defra.gov.uk email address. Please include the dataset owner and line manager.