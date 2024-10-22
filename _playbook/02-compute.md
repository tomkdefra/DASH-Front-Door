---
title: ""
permalink: /playbook/compute/
sidebar:
  - nav: "playbook"
---

# (PART) Platform Components {.unnumbered}

# Computing Resources {#compute}

## What are clusters?{#whatareclusters}

To be able to run code on the DASH platform, you need to access computational resource to run your code. In Databricks, computing resources are called clusters. A Databricks cluster is a set of computational resources and configurations on which you run data engineering, data science and data analytics workloads, from producing summary statistics and visualisations all the way through to machine learning and complex geospatial analysis.

By default, some of the clusters are always on, whilst others need to be turned on for users to be able to use them. Some users have the right to turn clusters on themselves, they are called business admin users. You can request business admin rights if you would like to be able to turn clusters on. This is particularly relevant if you want to use the notebook cluster or the geospatial clusters.

These clusters can be tailored to a specific task. For example, clusters will have a defined array of packages and libraries pre-loaded at start-up. Users are free to install libraries or packages, but these will not persist after the cluster has been restarted. DASH Platform users are not currently able to develop cluster configurations in the shared workspace, although a series of pre-built configurations have been developed. By default, users will have access to all the below clusters for their work.

## Preconfigured clusters in the shared Databricks Workspace

### RStudio clusters {#rstudioclusters}

These are general use clusters that users will do most of their basic analytics on. They are the only clusters that have RStudio as an app, and so all users looking to use RStudio will use these cluster.

The clusters are called: 

-   1a_RStudio
-   1b_RStudio

To check which R version and which packages (including versions) are pre-installed on the RStudio clusters, you need to check which Databricks runtime is used and then check this against the Databricks documentation. For example, a cluster with runtime 13.3 ML will have R version 4.2.2 and the following packages pre-installed: [Databricks Runtime 13.3 ML](https://learn.microsoft.com/en-gb/azure/databricks/release-notes/runtime/13.3lts-ml#r-libraries). Please note that if one is creating their own Personal Compute cluster they will need to use an ML Databricks runtime *and* have auto-termination disabled.

### Notebook

This is a distributed spark cluster containing multiple worker nodes which is designed for users who want to develop code using the Databricks notebook. 

### GeoVector

This is a distributed Spark cluster containing multiple worker nodes and advanced Geospatial libraries. This cluster is tailored for geospatial analysis and for users who want to develop code using Databricks Notebooks for processing Vector models. With more available compute, this cluster is much more appropriate for big geospatial analysis. 

Libraries include: 

-   pyspark_vector_files
-   geopandas
-   databricks-mosaic
-   sedona
-   rtree
-   matplotlib

### Training Cluster

The training cluster is a small Spark cluster which has been configured specifically to use the training notebooks provided by Databricks. Databricks has a whole array of training modules, from basic Databricks architecture to advanced machine learning with Spark. Most of these modules come with work along notebooks that should be completed on the training cluster. 

### Personal compute

More recently Databricks has enabled users to spin up personal compute clusters. These are intended for individual use. However, it is not possible to spin up unlimited clusters in the shared workspace, we therefore discourage users from spinning up personal compute

## Clusters in restricted data workspaces{#clustersrestricted}

The above clusters are all available within the shared workspace. There are also other workspaces for use of restricted data to which only few users have access. These workspaces do not have pre-configured clusters, instead some users in those workspaces have the ability to spin up clusters themselves.

### Business Admins (BusAdmin users) and what can they do?

Some DASH users will be granted additional privileges to be able to start clusters, commonly known as "to spinup". Those users are denoted as *BusAdmin users*. They are there to facilitate their teams' work as different analysis teams have different computing needs that potentially need bespoke configurations. Please remember that cluster creation is a *privilege*, not a right; if someone abuses it, it will be taken away.

Here is some general advice on how to manage a cluster:

-   Best practices on cluster configuration can be found here: [Best practices: Cluster configuration - Azure Databricks](https://learn.microsoft.com/en-gb/azure/databricks/clusters/cluster-config-best-practices). Please read them before continuing.

-   Best practices on spinning up personal compute clusters from Databricks can be found here: [Create a Personal Compute resource - Azure Databricks](https://learn.microsoft.com/en-gb/azure/databricks/clusters/personal-compute), they complement the previous point.

-   Please select the smallest VM you can perform your work with. A rule of thumb: E-series VMs are good for R based analytics. Information about VM types can be found here: [Virtual Machine series \| Microsoft Azure](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/).

-   You are strongly discouraged of using GPUs clusters unless you need them. They are very expensive.

DASH Support will be happy to discuss with you how to tailor your cluster configuration.

### T-shirt sizes

To make cluster creation simpler there is a selection of "T-shirt size" cluster profiles to choose from. When selected these limit the options available. For example, selecting an RStudio T-shirt size will have the settings required for RStudio server set and not shown as options.

### Init scripts

Init scripts are (usually small) shell scripts that run during the start-up of each cluster node before the Spark driver or worker JVM starts. Theses scripts are primarily used to pre-install Python and R libraries. They can also add certificates that we might need to access specific resources.\
They are particular useful where we want to:\
1. Ensure we have specific libraries/package configuration in place.\
2. Share our own set up easily with colleagues.\
More information can be found here: [Cluster node initialization scripts](https://docs.databricks.com/clusters/init-scripts.html)

#### Custom init scripts

There are init scripts associated with each databrick runtime. You can also create your own.

#### Init script Github repo

The simplest way to access working init scrpits is to clone the [init script repo](https://github.com/Defra-Data-Science-Centre-of-Excellence/init-scripts)

Instructions on how to clone a Github repo can be found in the Databricks folder. The DASH.sh file will now be in the repo section of the Workspace tab.

```{r, echo = FALSE, out.width = '100%'}
knitr::include_graphics("images/init_git.png", dpi = NA)
```

#### Creating a .sh file

You can also create your own file.

Log into databricks.\
Start in your respective "Workspace" explorer (tab located at upper left corner in Databricks home screen).

```{r, echo = FALSE, out.width = '100%'}
knitr::include_graphics("images/ini_image1.png", dpi = NA)
```

In the upper right corner, click add and select "File".\
Name the file "my_init_script.sh" (or something you like) and click "create file".

```{r, echo = FALSE, out.width = '50%'}
knitr::include_graphics("images/ini_image2.png", dpi = NA)
```

In the file created list what you want to be installed.

An example init script can be found here: [example init script](https://gist.github.com/pantelisindefra/508f02624074492e21967965d37985af) (\*)

```{r, echo = FALSE, out.width = '100%'}
knitr::include_graphics("images/ini_image3.png", dpi = NA)
```

#### Copy the path of your .sh file

For whatever .sh file you are using; in the Workspace Explorer right click on the filename (or click on the three vertical dots to the right) and select "Copy \> Path".\
Path is now copied to clipboard. It should look something like this: /Workspace/Users/firstname.lastname\@defra.gov.uk/my_init_script.sh

```{r, echo = FALSE, out.width = '100%'}
knitr::include_graphics("images/ini_image4.png", dpi = NA)
```

#### Create a PC cluster with a custom init script

Go to the "Compute" explorer (tab located at upper left corner usually 4 lines below "Workspace").\
Click on "Create with Personal Compute".

```{r, echo = FALSE, out.width = '100%'}
knitr::include_graphics("images/ini_image5.png", dpi = NA)
```

In the window that opens, make the relevant choices about name, runtime and node type.\
It is suggested to use Runtime 12.2 LTS unless you know of particular requirements to use another.

```{r, echo = FALSE, out.width = '100%'}
knitr::include_graphics("images/ini_image6.png", dpi = NA)
```

Click on the "Advanced options" tab. Under the "Advanced options" tab select the "Init Scripts" tab.\
In the form asking for "Init script path" paste the file path of the init script from above.\
The destination box, to the left of it, should read "Workspace".\
Note that this means you will have to delete the prefix "/Workpace" from the path. i.e. the path will read something like: "/Users/firstname.lastname\@defra.gov.uk/my_init_script.sh"\
Click "Add".

```{r, echo = FALSE, out.width = '100%'}
knitr::include_graphics("images/ini_image7.png", dpi = NA)
```

Click "Create Cluster".

If you click back on the "compute" tab you should see your culster in the list. Under status it should have a spining icon as the cluster spins up.\
Look out of the window, it takes a bit to make a cluster. (\~6' for the init script provided). After 6-7' our cluster should be up and running. The spinning icon will turn to a tick.

#### Check it is working

If we used Runtime 12.2 LTS the pre-configured `pandas` version is 1.4.2 (see [Databricks Runtime 12.2 LTS for Machine Learning - Azure Databricks \| Microsoft Learn](https://learn.microsoft.com/en-us/azure/databricks/release-notes/runtime/12.2ml#python-libraries) for a full list) but in our example init script we particularly asked for 1.5.3.

To test, create a notebook in your Databricks workspace buy clicking "New \> Notebook".

```{r, echo = FALSE, out.width = '50%'}
knitr::include_graphics("images/ini_image8.png", dpi = NA)
```

By default it is a Python notebook. It will be named "Untitled Notebook" plus the date. You can change this if you wish by double clicking on the name. Check it is running on your cluster by looking at the box just to the right of the "Run all" button, near the top right hand side. If there is no green circle you need to use the drop down to select your cluster.

```{r, echo = FALSE, out.width = '50%'}
knitr::include_graphics("images/ini_image9.png", dpi = NA)
```

In the first cell type:

    import pandas as pd  
    print(pd.__version__)

Then run it by clicking on the play icon (or press Shift + Return)

This should print: "1.5.3".

```{r, echo = FALSE, out.width = '75%'}
knitr::include_graphics("images/ini_image10.png", dpi = NA)
```

Alternative way to check\
Click on your cluster from the compute page.\
Click the tab "Apps" and then "Web Terminal".\
On the terminal that opens, type "pip show pandas".\
This prints information about the pandas package and the version should read "1.5.3"

```{r, echo = FALSE, out.width = '75%'}
knitr::include_graphics("images/ini_image11.png", dpi = NA)
```

You could also use "pip list" to print the version of every pip package.

If you get the correct version of pandas you have created a PC cluster that is initialised with your custom init script! 😊

(\*) Users are discouraged from using ad-hoc init scripts. If you want an init script to be used more extensively please make a formal github PR at this repo: [init-scripts](https://github.com/Defra-Data-Science-Centre-of-Excellence/init-scripts)

### Enable logging

By default logging is not activate for compute resources. If you want to enable logging you need to do the following, in the Cluster proporties/creation menu scroll down to `Advanced options` Click the `Logging` tab. Select `Destination` to be `DBFS`. A compute log path will appear. Databricks will create a subfolder with cluster_id under the destination and deliver logs there. More information can be found in the relevant documentation on [Compute log delivery](https://learn.microsoft.com/en-gb/azure/databricks/compute/configure#cluster-log-delivery).

### Turning -on and -off a cluster automatically

#### Turning on a cluster using a GUI

Users are expected to use the Databricks scheduler directly in order to turn on a cluster to run a job they want. Users can schedule a notebook run at particular scheduled times using the Databricks UI. The Databricks documentation on [Create and manage scheduled notebook jobs](https://docs.databricks.com/en/notebooks/schedule-notebook-jobs.html) has a simple walk-through. Importantly a cluster *will_not* turn itself off automatically so users need to do that either by the Databricks UI or the turn a cluster off using the API.

#### Turning off a cluster programmatically

Users can turn of a cluster programmatically by using the [Databricks API](https://docs.databricks.com/api/azure/workspace/introduction), the scheduler does not provide this functionality. The following code can be added in a Databricks notebook.

We first need to provide the relevant workspace and cluster id as variables:

```{python, eval = FALSE,python.reticulate = FALSE}
import json 
notebook_info = dbutils.notebook.entry_point.getDbutils().notebook().getContext().toJson() 
# Parse notebook information as JSON 
workspace_url = json.loads(notebook_info).get("tags", {}).get("browserHostName") 
# Get cluster ID 
cluster_id = dbutils.notebook.entry_point.getDbutils().notebook().getContext().clusterId().getOrElse(None)
print(f"Workspace URL is: {workspace_url} and Cluster ID is: {cluster_id}.")
```

(Please note that if we are doing a scheduled run, one needs to set the workspace URL (e.g. `adb-1234567890123456.78.azuredatabricks.net`) explicitly.)

We also need to have our [user token](https://docs.databricks.com/en/dev-tools/cli/authentication.html#id1). Please note that only users who have the ability to turn off clusters from the UI will also be able to user their token in order to turn of a cluster.

```{python, eval = FALSE, python.reticulate = FALSE}
# Personal token
token = "dapi123cd4cab5c6d7c89d01abc23d4567d8" # Not real token
```

We finally make the call to API asking to [`delete`](https://docs.databricks.com/api/azure/workspace/clusters/delete) the cluster, please note that the `delete` command terminates the Spark cluster with the specified ID, it does not *delete* it from the workspace.

```{python, eval = FALSE, python.reticulate = FALSE}
import requests
databricks_host = f"https://{workspace_url}"
api_version = "2.0"
cluster_id = cluster_id
headers = { "Authorization": f"Bearer {token}", }
api_url = f"{databricks_host}/api/{api_version}/clusters/delete"
response = requests.post(api_url, headers=headers, json={"cluster_id":cluster_id})
if response.status_code == 200:
    print("Cluster terminated successfully.")
else:
    print(f"Failed to terminate cluster. Error: {response.status_code}")
```

### Installing a package directly

Sometimes our cluster might be missing some binary package that we require. In that case, we can install package directly on the cluster ourselves. There are different ways of achieving that and please note that it will be better to add package installation in `init_scripts`.

#### Installing a binary package directly from the terminal

1.  Click on your cluster name from the Compute page.
2.  Click the tab "Apps" and then "Web Terminal".
3.  On the terminal that opens, type `sudo apt-get install XYZ`, where `XYZ` this package we want to install. The end result should look like this (we install the package `libedml5` here):

```{r, echo = FALSE, out.width = '75%'}
knitr::include_graphics("images/simple_install.PNG", dpi = NA)
```

More information on how to install packages can be found in the Ubuntu documentation page on [package management](https://ubuntu.com/server/docs/package-management).