---
title: ""
permalink: /playbook/
sidebar:
  - nav: "playbook"
---

# Introduction {#introduction}

## Data Analytics & Science Hub (DASH)

The Data, Analytics & Science Hub (DASH) is a service providing support to data scientists across Defra group. This support will be provided through:

-   The provision of reliable and easily accessible data, advanced tooling, and scalable compute through our cloud computing platform.
-   The provision of specialised data science training offerings to upskill data scientists.
-   The support and coordination of the wider data science community and embedding governance processes which enable this community to work effectively and apply their expertise towards the development of the novel and complex analytics needed for policy design and delivery.  


## Data Analytics and Science Hub Platform (DASH Platform)

The DASH platform is being developed to provide analysts and scientists within Defra group access to a wider range of datasets, advanced tooling and compute power. It is a cloud-based platform built in Microsoft Azure. Its purpose is to give users access to powerful computing resources, data, and up-to-date tools for data science and analysis. The focus has been on building a scalable and flexible platform to scale computing power with demand and provide a cost-effective service that can meet the changing needs of Defra's data science and data analysis community.


### Platform architecture


The architecture of the DASH Platform is displayed in figure \@ref(fig:dash-arch). (Release 5)

The primary tools that all users have access to are:

1.  A shared [Databricks](#databricks) workspace with access to a set of computing resources and databricks notebooks.
2.  An [Rstudio](#rstudio) environment which is mounted onto Databricks clusters.
3.  A [Posit Connect](#positconnect) server - which enables hosting dashboards and HTML files internal to Defra Group.
4.  [Azure Virtual desktop](#avd) with pre-installed Data Science tools. Power BI and VS Code.
5.  [GitHub](#git)

Additionally, some users have access to restricted Databricks workspaces. These workspaces are intended for the use of restricted data, with only pre-approved users added to them.

```{r dash-arch, fig.cap = "Overview of the DASH Platform's archtecture", fig.align='center', out.width='100%', echo=FALSE}
knitr::include_graphics("images/release_5_dash_architecture.PNG")
```

In addition to these tools users also have access to Data hosted in the DASH Platform Data Lake. This is documented through our data catalogue. See section \@ref(datalake) for more information about data on the DASH Platform.


### Getting access to the DASH platform

The DASH Platform is accessible through a web browser on any Defra device connected to the Defra network. Access to this platform will be authenticated using Defra's Azure Active Directory.

Access to the DASH platform can be requested through Defra's MyIT system, on the MyPortal desktop app. [DASH: Join, Modify, Leave](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=a26ef89e1b8c3550848b8594e34bcb68)

More information about how to fill out the Join, Modify, Leave form can be found on MyIT. [Join, Modify, Leave Knowledge Article](https://defragroup.service-now.com/esc?id=kb_article&table=kb_knowledge&sysparm_article=KB0100654) 
  
Further onboarding information can be found on the DASH Sharepoint site here: [DASH onboarding](https://defra.sharepoint.com/sites/Community448/SitePages/CDAP-The-Common-Data-Analytics-Platform.aspx)
  
For more information about using the DASH platform for project work please contact [datascience\@defra.gov.uk](mailto:datascience@defra.gov.uk){.email} with the "DASH Platform access" in the subject line.

**Access to the DASH Platform is subject to our [acceptable usage policy](#aup), please ensure that you are familiar with this before using the platform**

### Leaving the DASH platform

Similarly to joining the DASH platform, to remove yourself from DASH use the [DASH: Join, Modify, Leave](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=a26ef89e1b8c3550848b8594e34bcb68) form. When you are leaving please ensure you have done an adequate hand-over to your team (transferring ownership of code, dashboards, etc.), you will lose access to Databricks, Posit Connect Server and the AVD(s). 

### Acceptable Usage Policy {#aup}
Please ensure you report any potential security incidents or breaches to the DASH team.

All use of the DASH platform is expected to align with [HMG AI framework](https://www.gov.uk/government/publications/generative-ai-framework-for-hmg).


**Data**

The DASH Platform brings together data and tools to enable data scientists to work more efficiently. While we are keen to reduce the friction in gaining access to high-quality data it is important that data is kept secure.

The use of data on the DASH Platform is dependent on the following:

*	Adhere to the policies and guidance set out in Defra’s Information Management Framework and take all measures to protect personal and sensitive information.
*	Complete the data handling online training and adhere to the data handling section of the Defra code of conduct.
*	Do not move data into the dbfs or the RStudio workspace that should not be viewed by any user of the platform.
*	Users take personal responsibility for loading data in the LAB, including responsibility for not loading and sharing personal/commercially sensitive data in Lab/dbfs areas.
*	Users should be aware of restrictions on data by referring to the Data Catalogue and take care not to derive products from data that are in contravention of the licence/sharing agreements.
*	If in doubt, contact IAO for advice on using the data.
*	Don’t take restricted data, including derived data and models, from the base and make open in Lab/dbfs or in other systems, resulting in unauthorised access.
*	Not use data for purposes which are not supported by the licence agreements e.g., sharing derived products with users not supported by the licence.
*	Ensure that data transfers onto and within the DASH Platform are conducted safely and securely for more information see the data section \@ref(data).
*	Do not store any data on the DASH Platform that is classified as SECRET or TOP SECRET, the DASH Platform has been authorised to store and compute data that is PUBLIC, OFFICIAL, and OFFICIAL-SENSITIVE.

**Code**

A core goal of DASH is to make analytical project work more collaborative, reproducible, and discoverable. To support this, we request that you use GitHub to store the source code behind your work, preferably linked to Defras enterprise account.

The use of GitHub is dependent on the following:

*	The analytical lead will take, or delegate, responsibility for the management of the project GitHub repository.
*	Please adhere to the NCSC’s guidance for GitHub repositories. 
*	Two-factor authentication should be enabled when accessing GitHub.
*	Please avoid using GitHub to store data, either use the Data Lake for persistent data or RStudio Connect Pins where data is required for a dashboard.
*	Any source code or documentation containing sensitive information should not be stored in GitHub.
*	Where sensitive data has been committed by accident please refer to the GitHub guidance for removing sensitive data.
*	Care should be taken to ensure that no credentials or secrets, e.g., usernames, passwords, database connection strings or API keys are committed to GitHub.
*	Defra work should be linked to the Defra organisation.
*	Carefully plan for any open-source repositories in line with the government service manual guidelines.
*	For more detailed information about GitHub best practice please explore the GitHub section \@ref(git)

**Hosting**  

*	Ensure that appropriate permissions are applied to content hosted on te Posit Connect server including “Pinned data”.  
*	Embed metadata with content deployed on RStudio Connect see (section \@ref(positconnect)).  
*	Regularly review your content deployed to the DASH Platform RStudio Connect server.  


## GitHub

In addition to requesting access to the DASH platform a GitHub account linked to Defra's enterprise organisation is required to make efficient use of the platform.

-   A GitHub account can be created at GitHub's website.
-   If you already have a GitHub account, please make sure your Defra email address is associated with your account.
-   You may have multiple email addresses associated with your email account. If you leave your government role you may retain your GitHub account although your access to restricted repositories will be withdrawn.
-   To collaborate on Github repositories under the Defra enterprise please connect your personal account to the Defra organisation by contacting [datascience\@defra.gov.uk](mailto:datascience@defra.gov.uk){.email} with "GitHub" in the subject line and include your username and email.
-   2 factor authentication should be enabled for all GitHub accounts. Further guidance for this can be found on GitHub's website.

More information about the use of GitHub through the DASH Platform can be found in our GitHub section \@ref(git) and the user guides therein.

After you have been provided access to the DASH Platform you will be invited to attend training and be added to a Teams channel to access support. For more information about this please see the \@ref(support) section.