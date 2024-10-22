---
title: ""
permalink: /playbook/data/
sidebar:
  - nav: "playbook"
---

# Data {#data}

Our ambition is to simplify and streamline access and processing of data from across the Defra group for users of the DASH platform, enabling them to retrieve the necessary data for analysis and scientific purposes. We achieve this by:   

- Providing and maintaining the DASH data lake as a centralised repository for storing large volumes of structured and unstructured data.
- Delivering a range of data services to analyse and acquire data from source, ingest, engineer, curate and govern data in the DASH lake so it can be quickly and efficiently found, accessed, processed, and used by users of the DASH platform.
- Empowering users of the DASH platform to integrate their own data through a Bring Your Own Data (BYOD) approach, allowing for seamless blending with the centrally governed data.

The DASH data lake provides access to common datasets from a single place. Bringing data storage closer to the provision of tooling increases efficiency and performance and fosters collaboration and knowledge sharing. Enabling teams to work on the same datasets whilst reducing the need for data to be stored multiple times. Through the implementation of access controls, encryption, and auditing mechanisms, the secure data lake ensures that sensitive data is protected and complies with Defra’s regulatory requirements.  

The DASH Platform has an approved ‘Data Protection Impact Assessment (DPIA)’ which we review at regular periods.  

In summary, the secure data lake provides a foundation for efficient, collaborative, and secure data analytics. When integrated with Databricks platform, it enhances the capabilities of analysts and data scientists, allowing them to extract valuable insights from diverse and large datasets while ensuring data security and governance.  

This section of the Playbook describes the DASH data lake and associated data services in greater detail and summarises our data principles. For FAQs please see 'Frequently asked data questions' in the Data Section of the Playbook.  

Before using and accessing data on the DASH Platform please read the [Acceptable Usage Policy](#aup)

## The DASH Data Lake{#datalake}

The DASH Platform has a dedicated data lake to securely store data. A data lake is a centralised repository designed to store, process, and secure large amounts of structured, semi structured, and unstructured data. The data lake can store OFFICIAL and OFFICIAL SENSITIVE data; the latter is usually restricted to named users.  

The data lake is managed by the DASH Platform Data Team, a team of dedicated Data Analysts, Data Architects and Data Engineers.  

Data Analysts: responsible for capturing technical data requirements and sourcing, cataloguing and stewarding data on the DASH Platform.  

Data Architect: responsible for designing the overall structure and organisation of the DASH Data Lake, defining data models, and ensuring that the DASH Platform data architecture aligns with Defra’s enterprise data architecture.  

Data Engineers: responsible for designing, implementing, and managing data ingestion pipelines, utilising automation to streamline the process and ensure the continuous delivery of analysis-ready data to the DASH Platform.  

Our **Data Principles** describe the teams' ways of working <link>.  
 
### How we organise data in the data lake 

The DASH Data Lake is structured into **Zones** (Blob containers in Azure), each represents a particular stage of transformation of ingested data e.g. STAGING-MANUAL, RAW, BASE, LAB etc.    

The two zones visible and relevant to users are the **BASE** and **LAB** zones.   

Importantly, both the BASE and LAB zones are **mounted** to Defra’s external Azure cloud storage, data stored here is secure and backed up. Additionally, a further area exists for temporarily storing data, the Databricks File System **(DBFS)**. This is not part of Defra’s external Azure cloud storage.  

### BASE Zone 

All data stored in the BASE zone is ingested and maintained by the DASH Data Team - this data is referred to as **‘Governed data’**. This data is typically of high value to multiple users across the DASH Platform.   

The BASE zone is fully managed through the environments Dev/Test, PreProd, Prod, and all ingestion is controlled by automated Azure Data Factory scripts. The data stored in BASE can be either unrestricted (available to all users) or restricted (available to only those permitted to access the data).  

Governed data is structured within the data lake to agreed data architecture principles (which describe the design of data lake storage zones and ingestion pipelines) and catalogued in the DASH Platform Data Catalogue to make it findable and accessible.  

Users can request/suggest datasets to be loaded into BASE, following this process [How do I request a new Governed dataset to be added to the DASH Platform?](#requestgovdata)

Once requested a triage will be performed to assess potential issues and limitations associated with the onboarding of the new data. A data analyst will then work with you to discuss your requirement through the Data Assessment process. The DASH Platform data team will work to ingest the data as quickly and efficiently as possible to meet the business need. For example, a one-off tactical data load may be appropriate to provide quick access to a dataset whilst an automated pipeline is developed. <link to principle>  

Currently, all data in the BASE zone is structured in the same persistent format. The latest version of the data loaded in the data lake will always be in the `../LATEST folder`. The file path to this data will not change.  

Example BASE zone file path

- The default path to mounted unrestricted Governed Data.
`/dbfs/mnt/base/unrestricted`

- Organised by data source.
`/source_defra_data_services_platform`

- Categorised by dataset name.
`/dataset_areas_of_outstanding_natural_beauty`

- Describes the format of the data.
`/format_SHP_areas_of_outstanding_natural_beauty`

- The latest version of the dataset in the data lake.
`/LATEST_areas_of_outstanding_natural_beauty`

- The actual file, this typically follows the source dataset name, and is persistent where possible (data providers may change file names and field names over time).
`/Areas_of_Outstanding_Natural_Beauty_England.shp`

Additionally, when the data is refreshed a copy of the older version is retained in a `/SNAPSHOT` folder. This is useful if you want your code to always point at a specific (and persistent) dated version of a dataset. For information, the latest SNAPSHOT dated version is always the same as the LATEST version.  

Over time, this file path will be adjusted to meet a Medallion Architecture as part of the Unity Catalog rollout, there will be a period where data from both file paths will be available. Throughout this process, users will be consulted and provided with ample time to adapt existing code to align with the new file path. <see link to unity catalogue section>  

### LAB Zone 

Users of the DASH platform can bring their own data (BYOD) into the platform via the LAB zone of the data lake. The LAB zone has been specifically designed so that users can bring datasets up to 2gb into the platform to perform their own analysis, modelling, and data manipulations. Data in this zone is ingested, controlled, and managed by the end user.  

**There is an upload limit of 2 gigabytes for uploading of single dataset.**  

Data can be loaded into LAB as ‘unrestricted’ visible to all DASH Platform users or ‘restricted’. The latter is currently dependent on users having a dedicated Databricks workspace. Users take full responsibility for not loading and sharing personal/commercially sensitive data in LAB zone, as described in the [Acceptable Usage Policy](#aup).  

Example LAB zone file path: `/dbfs/mnt/lab/unrestricted`  

**We expect over time DASH Platform users will create new datasets in their LAB area that are of wider value to users of the Platform e.g. data considered to be of ‘Gold’ standard, new data created to a level of high quality or completeness. We will work with users to understand the data, catalogue and migrate to the Governed BASE zone.** 

[How do I load a large dataset into my LAB area (over 2 gb)?](#over2gb) 

### The Databricks File System (DBFS) 

Additionally, users can load data into the DBFS, a unified file system provided by Databricks that abstracts underlying cloud storage. Importantly, data stored in the DBFS is not backed up or managed by DASH Data Team (the BASE and LAB zones are mounted to Defra’s external Azure cloud storage).  

The DBFS should only be used as a transient data store as part of the process for loading data into the LAB zone. **It is not intended or suitable for longer term data storage.**  

Users take full responsibility for not loading and sharing personal/commercially sensitive data in the DBFS as described in the [Acceptable Usage Policy](#aup).  

Once data is safely transferred to the LAB zone users should remove remaining data from the DBFS. **Data in the DBFS may be removed by admins without notice.**  

Example DBFS file path: `/dbfs/FileStore`  

Note this does not have ‘mnt’ in the file path which shows that any data stored here is not mounted to the Defra external Azure cloud storage (and therefore backed up).  

<see further operational guidance on process for loading data, assuming this exists somewhere?>  

### The DASH Data Catalogue

All data stored in the Governed BASE zone has an entry in the [DASH Platform Data Catalogue](https://app.powerbi.com/groups/me/apps/5762de14-3aa8-4a83-92b3-045cc953e30c/reports/c8802134-4f3b-484e-bf14-1ed9f8881450/ReportSectionff2a0c223272005d9b10?experience=power-bi).  

All DASH Platform users that are members of the [DASH Platform | Microsoft Teams channel](https://teams.microsoft.com/l/team/19%3Ac0a7ff5361a34d47be2f104f973f132b%40thread.tacv2/conversations?groupId=c48b3647-2e50-4682-b7c1-f96c7d090816&tenantId=770a2450-0227-4c62-90c7-4e38537f1102) are automatically granted access to the data catalogue. Instructions on how to use the data catalogue are in the ‘About’ view. Users take full responsibility for understanding the data and associated terms and conditions.  

Further information is found in [Principle 6: Making data findable and accessible](#principle6)  

## Data Principles 

The DASH Data Team operates a broad set of Data Principles. These principles are crucial for the effective management and utilisation of the DASH platform data lake.  

The principles provide a framework for making decisions about how data is collected, stored, processed, and made available to users in the Governed BASE zone.  

```{r, echo = FALSE, out.width = '80%'}
knitr::include_graphics("images/data1.png", dpi = NA)
```

### Principle 1: Understand data needs  

We will work to understand your data requirements, for example, the problem you are trying to solve? What data you need? Who will be using the data?  

We will achieve this by completing our ‘Data Assessment’ with you. This is a collaborative process for capturing the required information to make an informed decision on how best to source and on-board the data safely onto the DASH Platform.  

This is an important step of the data on-boarding process and aims to: 

- Explore and identify the data's origin, aiming to obtain it from as close to the original source as possible. 
- Understand the source data update frequency, and identify the appropriate refresh for the DASH Platform. 
- Capture the format(s) required for the DASH Platform and identify if the data requires converting to an optimised format such as GeoParquet. 
- Identify any possible restrictions that apply to the data and work with the Information Asset Owner to ensure correct procedures are followed when handling, storing and accessing from the DASH Platform. 

We will make an agreed decision on how best to make the data available, either through the Governed BASE zone or loaded directly into the LAB zone.  

The complexities of the data and ingestion patterns will dictate the time it takes to make the data available to users in the Governed BASE zone.  

However, if necessary, we will work to **fast-track** data onto the DASH Platform to make data available to users, for example via a tactical load to the LAB area whilst sustainable automated data pipelines are built and tested. 

To request a new  governed dataset: [How do I request a new Governed dataset to be added to the DASH Platform?](#requestgovdata)

### Principle 2: Identify a named data owner for each asset  

We will identify an owner for each dataset that we load in the Governed BASE zone.  

During the Data Assessment process, we will identify a data owner, so that accountability for each dataset can be designated to a business unit or team. If the dataset contains sensitive and/or personal data, then we must identify an Information Asset Owner (IAO).  

Assigning data ownership helps establish a single point of accountability for the quality, security, and appropriate use of the data. It ensures that someone is responsible for making decisions regarding the data. Also, it serves as a contact for users to obtain access to a restricted dataset.  

<add link to request access to existing restricted dataset>  

### Principle 3: Data Acquisition

We will not commission the collection of new data; the DASH Platform is designed to acquire existing datasets based on the principles described.  

We will proactively acquire datasets that we think will be of wider benefit to the users of the DASH Platform. We will reactively acquire datasets that you have requested (via MyIT request<link>).

If the data, you require doesn’t exist and there is a demonstrable business use for capturing it then follow Defra’s data acquisition guidance: [Data Acquisition Policy](https://defra.sharepoint.com/sites/def-contentcloud/_layouts/15/DocIdRedir.aspx?ID=CONTENTCLOUD-190616497-19982).  

We expect over time DASH Platform users will create new datasets in their LAB area that are of wider value to users of the platform e.g. data considered to be of ‘Gold’ standard, new data created to a level of high quality or completeness. We will work with users to understand the data, catalogue and migrate to the Governed BASE zone.  

### Principle 4: Protect your data 

We will ensure that data is protected appropriately and complies with all relevant data policies and legislation before we load data into the Governed BASE zone of the DASH Platform. Our Data Assessment process helps us to identify these requirements. 

We will classify data based on the specific terms and conditions of the data on a case-by-case basis e.g. license restrictions, data sharing agreements and sensitivity. We will apply different security measures based on the classification of the data to ensure that appropriate security controls are in place and only those that have permission to access the data are able to. The access classification of the data, along with the usage terms and condition is visible to users in the [DASH Platform Data Catalogue](https://app.powerbi.com/groups/me/apps/5762de14-3aa8-4a83-92b3-045cc953e30c/reports/c8802134-4f3b-484e-bf14-1ed9f8881450/ReportSectionff2a0c223272005d9b10?experience=power-bi).  

For example:

- The data is OFF SEN and has strict terms and conditions around its use which the user must understand and agree to before access can be granted e.g. Data managed by the Defra Farming Stats team (Farm Business Survey and June Agricultural Survey) requires permission from that team, all users must have signed a confidentiality agreement document before access can be granted. 
- License restrictions. Some data is only available for use by specific teams or Defra Business Units pending on the T&Cs. For example, the ‘National Polygon Service’ data is available on request to Defra core users only.

We will regularly review and update access permissions to ensure that only authorised individuals have access to restricted data.  

The DASH Platform has an approved ‘Data Protection Impact Assessment (DPIA)’ which we review at regular periods.  

The Azure data lake encrypts data at rest and data in transit (also known as data in motion) is also always encrypted in Data Lake Store. See [Azure encryption](https://learn.microsoft.com/en-us/azure/security/fundamentals/encryption-overview).  

We hope by addressing these aspects, we can demonstrate a commitment to data security and compliance, reassuring data owners that their information is being handled responsibly in the DASH Platform. We will regularly update our policies and procedures for protecting your data in response to evolving requirements and data policies (working closely with colleagues in the Defra Chief Data Office).  

<link somewhere to the process for requesting access to existing restricted data>  

### Principle 5: Sharing Data 

The Defra group is committed to making its data and information assets as open as possible by making them: findable, accessible, interoperable, and reusable. These are known as the **'FAIR principles'**.  

By default, we will implement the 'FAIR principles' for data under our governance on the DASH Platform; ensuring data discoverability through our Data Catalogue and optimising formats. Access to data will only be restricted when necessary, and any restrictions will be clearly documented (see ‘Protect your data’<link to principle>).  

We advise incorporating the 'FAIR principles' into your work on the DASH Platform, such as when creating new datasets and constructing models. This ensures that your work can be made both shareable and discoverable within the DASH Platform and the broader analytical community.  

Further information on Defra’s commitment to share data is available: [Defra's Data Sharing Policy](https://defra.sharepoint.com/:w:/r/sites/def-contentcloud/_layouts/15/Doc.aspx?sourcedoc=%7B4d9d738d-b55d-4658-ab94-ff9a00ba8d32%7D&action=default&mobileredirect=true) 

### Principle 6: Making data findable and accessible{#principle6}

We will make it easy for you to find and access data within the DASH Platform. All Governed data will be discoverable in the [DASH Platform Data Catalogue](https://app.powerbi.com/groups/me/apps/5762de14-3aa8-4a83-92b3-045cc953e30c/reports/c8802134-4f3b-484e-bf14-1ed9f8881450/ReportSectionff2a0c223272005d9b10?experience=power-bi).  

The Data Catalogue blends metadata created by the data publisher with DASH specific information to help you discover data in our Governed BASE zone, providing the information you need to have confidence in using the data.  

It’s the DASH Platform user's responsibility to carefully read the information provided in the Data Catalogue. It's important that you understand data quality, latest versions and adhere to the terms and conditions of usage. By doing so, users can contribute to the secure and effective use of data on the DASH Platform.  

We will continuously look at ways of improving data discovery, for example on-boarding new data cataloguing tools to both improve the data discovery experience for users and help the DASH Data Team better manage the data assets on the DASH Platform. Over time we will implement data discovery tools to the LAB zone making it easier to understand what data colleagues have loaded and shared on the platform.  

### Principle 7: Help users understand and discover data in the platform

We will store up-to-date metadata for every dataset we store in the Governed BASE zone so the data we manage is clearly understood and discoverable. We store metadata in the [DASH Platform Data Catalogue](https://app.powerbi.com/groups/me/apps/5762de14-3aa8-4a83-92b3-045cc953e30c/reports/c8802134-4f3b-484e-bf14-1ed9f8881450/ReportSectionff2a0c223272005d9b10?experience=power-bi). 

We will reuse and link to existing metadata where this is published by data owners, for example the Defra Data Services platform. We will combine this with DASH specific metadata, only capturing additional metadata where necessary such as date sourced, date loaded and access restrictions. We will constantly refresh our metadata so that users can rely on up-to-date information about the data stored on the DASH Platform.  

We will reuse existing metadata standards where we can, such as GEMINI 3.2. and align with Defra policies such as the [Metadata Policy](https://defra.sharepoint.com/:w:/r/sites/def-contentcloud/_layouts/15/Doc.aspx?sourcedoc=%7Bd61cbb25-9d22-400f-84a7-d236e22c3b36%7D&action=default&mobileredirect=true) We will seek to integrate with existing Defra metadata systems where possible.  
 
### Principle 8: Making data reusable  

We will acquire and store datasets in a variety of formats in our Governed BASE zone.  Some of these will need to be compressed or converted to other cloud optimised format(s) better suited for analytics and efficient storage within the data lake.  

We integrate the **FAIR** principles into our Data Principles, guaranteeing that data is Findable, Accessible, Interoperable, and Reusable. Our objective is to ensure that data is stored and presented in a manner that is easily discoverable, accessible, compatible, and optimised for use on the DASH Platform.  

```{r, echo = FALSE, out.width = '80%'}
knitr::include_graphics("images/data2.png", dpi = NA)
```

For example, where applicable we will convert data into formats such as Parquet or GeoParquet, in addition to retaining the original format.  

It's important to utilise Parquet and GeoParquet formats for data analysis on the Databricks platform due to their efficiency and compatibility. Parquet's columnar storage minimises I/O and optimises query performance, crucial for handling large datasets. GeoParquet extends these benefits by supporting geospatial data types, enabling seamless analysis of spatial data alongside traditional datasets. This combination enhances scalability, speed, and versatility, facilitating more effective and comprehensive data analysis workflows on the Databricks platform.  

Where possible, the cloud optimised formats and other conversions will be obtained directly from the source rather than performing the conversions ourselves.  

### Principle 9: Understand and maintain the quality of the data stored in the lake 

We are committed to sourcing data from trusted and reliable sources. This helps ensure the integrity, accuracy, and reliability of the data ingested into the Governed BASE zone, fostering a foundation for accurate and reliable data analytics.  

We are committed to capturing and cataloguing metadata associated with data quality; this plays a crucial role in describing the characteristics of the data we store in the Governed BASE zone. We will provide this information in our [DASH Platform Data Catalogue](https://app.powerbi.com/groups/me/apps/5762de14-3aa8-4a83-92b3-045cc953e30c/reports/c8802134-4f3b-484e-bf14-1ed9f8881450/ReportSectionff2a0c223272005d9b10?experience=power-bi), for example, ‘Data Lineage’ describes the transformations of data, providing insights into its history and changes.  

In time, we will introduce data quality checks to the data we ingest; implementing thorough data validation and quality assurance processes – using the standards recommended by Q-Fair. These will include rigorous checks for accuracy, completeness, and consistency, allowing us to maintain high standards in our datasets and support the reliability of your analytical insights. Additionally, we will aim to determine from the quality of the data if further investment is required to meet the needs of users.

### Principle 10: Hold data for as long as it’s useful

We will store data in the DASH Platform in accordance with an agreed retention period. We will follow the data retention guidance as outlined in [Defra’s Data and Information Retention Policy](https://eur03.safelinks.protection.outlook.com/?url=https://defra.sharepoint.com/sites/def-contentcloud/_layouts/15/DocIdRedir.aspx?ID%3DCONTENTCLOUD-190616497-19983&data=05%7c01%7ccontentteam%40defra.gov.uk%7cac3694db74854f06e0ae08da9bb7efef%7c770a245002274c6290c74e38537f1102%7c0%7c0%7c637993511553205205%7cUnknown%7cTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7c3000%7c%7c%7c&sdata=FxOz93AHWJDea/ZTfWA4RbX5xJADY7zRxJ3nKBR8Hkk%3D&reserved=0).  

We will agree data retention on a case-by-case basis in consultation with the relevant Information Asset Owners and data owners. We will use the Data Assessment process to identify the retention requirements and store this information in our Data Catalogue.  

Data that we identify as having reached the end of its retention period or is no longer necessary for the defined purpose will be securely deleted in accordance with Defra policy. Dataset owners will be notified to eliminate any sort of doubt or confusion, users will be given prior notice to minimise any impact. Secure deletion methods will be employed to ensure that data is irrecoverable.  


---

## Frequently asked data questions 

 
### How do I discover the data that is available to me on the DASH platform? 

All data stored in the BASE zone has an entry in the DASH Platform Data Catalogue. This data is referred to as ‘Governed data’ and is ingested and maintained by the DASH Data Team.

### How do I request a new Governed dataset to be added to the DASH Platform?{#requestgovdata}

If you want to request a new dataset to be loaded into the Governed BASE zone, please raise a request in MyIT. The request will be triaged by a member of the team, and you will be updated with progress. Please remember that you can load data up to 2gb into the LAB zone yourself, if you require quick access to the data.  

[New or updated governed data - MyPortal (service-now.com)](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=7a5bd7ba1b553d50848b8594e34bcb8b)

### How do I load a large dataset into my LAB area (over 2 GiG)?{#over2gb} 

If you want to load a large dataset into your LAB area that is over 2 GiG in size, please raise a request in MyIT. A member of the DASH Data Team will be in touch to discuss the details and move the data to an agreed location on your behalf.  

[Manual upload to LAB - MyPortal (service-now.com)](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=a63c098e1b09b510848b8594e34bcbfd)  

### How do I access a Restricted dataset that I have seen available in the Data Catalogue? {#restrictedDataAccess}

The Data Catalogue contains information about all the data in the Governed BASE zone. Data is classed as ‘unrestricted’ or ‘restricted’.  

Data classed as ‘restricted’ is not accessible by default. Please read the terms and conditions of use. Data can be ‘restricted’ for several reasons, for example: 

- The data is OFF SEN and has strict terms and conditions around its use which the user must understand and agree to before access can be granted e.g. Data managed by the Defra Farming Stats team (Farm Business Survey and June Agricultural Survey) requires permission from that team, all users must have signed a confidentiality agreement document before access can be granted.
- License restrictions. Some data is only available for use by specific teams or Defra Business Units pending on the T&Cs. For example, the ‘National Polygon Service’ data is available on request to Defra core users only.  

If you think you have a valid business case to access data classified as restricted, please raise a request in MyIT. You will require evidence that you have approval from the data owner to access the data, as detailed in the Data Catalogue ‘Access Approver’ field. The request will be triaged by a member of the team, and you will be updated with progress.  

[Access to restricted data - MyPortal (service-now.com)](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=7205ba601b1db910848b8594e34bcb27)  

Additionally, users will require access to a suitable dedicated workspace for accessing the data.  

Overtime the process for granting and managing access to ‘restricted’ data will be managed by Unity Catalog.

### How do I securely add restricted data to my LAB area without sharing it to all users on the platform? 

The default setting for the DASH Platform is that users can access and view each other's LAB areas, this aids collaboration across the platform. However, users may need to load and use data that isn't shareable to all users.  

Currently, this is achieved by having access to dedicated workspace that allows users to access a `dbfs/mnt/lab/restricted/` work area. Workspaces are typically shared across a business unit or project, where it's safe for a smaller number of users to access one another's restricted LAB work areas.  

Workspaces are currently used to provide access to restricted datasets in the Governed area. The number of workspaces is limited so a valid business case will be required.  

Overtime the process for granting and managing access to ‘restricted’ data will be managed by Unity Catalog.  

### What is a workspace and why do I need to access one? 

A Databricks Workspace is an environment for accessing all of your Databricks assets. A workspace organizes objects (notebooks, libraries, dashboards, and experiments into folders and provides access to data objects and computational resources.  

All users are setup with access to the DASH shared workspace by default, this can be viewed in the top right of the window e.g. PRDDAPINFDB2401.  

Organisational, team or project workspaces (aka dedicated workspaces) are currently required to access restricted Governed data and a restricted area of the LAB zone. Dedicated workspaces are typically used by groups of common users, typically a business unit or project. For example, the ‘Environmental Land Management Project’ team has a workspace for users that are part of Farming and Countryside Programme (FCP) Directorate within the Core Defra Entity to allow them to work collaboratively with each other.   

Additionally, dedicated workspaces allow named users to control the available compute by managing ‘Clusters’ specifications e.g. to tailor the available compute to meet the needs of the project. [What are clusters?](#whatareclusters) [Clusters in restricted data workspaces](#clustersrestricted)  

The number of workspaces we can provide in the DASH platform is currently limited so a valid business case will be required.  

To request a new workspace:  

[Request for a New Workspace - MyPortal (service-now.com)](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=1c8357b11bf1bd10848b8594e34bcb37)  

Users can also request access to existing workspaces, any user requesting access will need to have prior permission to access the data that can be viewed from the workspace:  

[Request Access to a Workspace - MyPortal (service-now.com)](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=cefd88061bf9bd10848b8594e34bcb2d)

 

Overtime the requirement for project teams to have specific workspaces will become redundant by the introduction of Unity Catalog. 