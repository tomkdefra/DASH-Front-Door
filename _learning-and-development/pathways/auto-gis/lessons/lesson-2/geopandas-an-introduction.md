---
title: "Geopandas an introduction"
permalink: /learning-and-development/pathways/auto-gis/lessons/lesson-2/geopandas-an-introduction/
sidebar:
  nav: "auto-gis"
---


# Geopandas: an introduction

In this section, we will cover the basics of *geopandas*, a Python library to
interact with geospatial vector data.

[Geopandas](https://geopandas.org/) provides an easy-to-use interface to vector
data sets. It combines the capabilities of *pandas*, the data analysis package
we got to know in the [Geo-Python
course](https://geo-python-site.readthedocs.io/en/latest/lessons/L5/pandas-overview.html),
with the geometry handling functionality of
[shapely](../lesson-1/geometry-objects), the [geo-spatial file format support
of fiona](vector-data-io) and the [map projection libraries of
pyproj](map-projections).

The main data structures in geopandas are `GeoDataFrame`s and `GeoSeries`. They
extend the functionality of `pandas.DataFrame`s and `pandas.Series`. This means
that **we can use all our *pandas* skills also when we work with
*geopandas*!**. 

:::{tip}

If you feel like you need to refresh your memory about pandas, head back to
[lesson
5](https://geo-python-site.readthedocs.io/en/latest/lessons/L5/pandas-overview.html)
and [lesson
6](https://geo-python-site.readthedocs.io/en/latest/notebooks/L6/advanced-data-processing-with-pandas.html)
of Geo-Python.
:::

There is one key difference between pandas’s data frames and geopandas’
[`GeoDataFrame`s](https://geopandas.org/en/stable/docs/user_guide/data_structures.html#geodataframe):
a `GeoDataFrame` contains an additional column for geometries. By default, the
name of this column is `geometry`, and it is a
[`GeoSeries`](https://geopandas.org/en/stable/docs/user_guide/data_structures.html#geoseries)
that contains the geometries (points, lines, polygons, ...) as
`shapely.geometry` objects.

```{code-cell} ipython3
:tags: [remove-input]

import pathlib
import geopandas
import numpy
import pandas

DATA_DIRECTORY = pathlib.Path().resolve() / "data"

HIGHLIGHT_STYLE = "background: #f66161;"

# so the following block is a bit of bad magic to make the table output look
# nice (this cell is hidden, we are only interested in a short table listing
# in which the geometry column is highlighted).
#
# For this, we
#    1. convert the geopandas back into a ‘normal’ pandas.DataFrame with a shortened
#       WKT string in the geometry column
#    1b. while doing so, get rid of most of the columns (rename the remaining ones)
#    2. apply the style to all cells in the column "geometry", and to the axis-1-index "geometry"

# Why did I got via a ‘plain’ `pandas.DataFrame`?
# `pandas.set_option("display.max_colwidth", 40)` was ignored, so this seemed like the cleanest way

df = geopandas.read_file(DATA_DIRECTORY / "finland_topographic_database" / "m_L4132R_p.shp")

df["geom"] = df.geometry.to_wkt().apply(lambda wkt: wkt[:40] + " ...")

df = df[["RYHMA", "LUOKKA", "geom"]]
df = df.rename(columns={"RYHMA": "GROUP", "LUOKKA": "CLASS", "geom": "geometry"})

(
    df.head().style
        .applymap(lambda x: HIGHLIGHT_STYLE, subset=["geometry"])
        .apply_index(lambda x: numpy.where(x.isin(["geometry"]), HIGHLIGHT_STYLE, ""), axis=1)
)
```



## Read and explore geo-spatial data sets

Before we attempt to load any files, let’s not forget to defining a constant
that points to our data directory:

```{code-cell} ipython3
import pathlib 
NOTEBOOK_PATH = pathlib.Path().resolve()
DATA_DIRECTORY = NOTEBOOK_PATH / "data"
```

In this lesson, we will focus on **terrain objects** (Feature group:
"Terrain/1" in the topographic database). The Terrain/1 feature group contains
several feature classes. 

**Our aim in this lesson is to save all the Terrain/1
feature classes into separate files**.

*Terrain/1 features in the Topographic Database:*

|  feature class | Name of feature                                            | Feature group |
|----------------|------------------------------------------------------------|---------------|
| 32421          | Motor traffic area                                         | Terrain/1     |
| 32200          | Cemetery                                                   | Terrain/1     |
| 34300          | Sand                                                       | Terrain/1     |
| 34100          | Rock - area                                                | Terrain/1     |
| 34700          | Rocky area                                                 | Terrain/1     |
| 32500          | Quarry                                                     | Terrain/1     |
| 32112          | Mineral resources extraction area, fine-grained material   | Terrain/1     |
| 32111          | Mineral resources extraction area, coarse-grained material | Terrain/1     |
| 32611          | Field                                                      | Terrain/1     |
| 32612          | Garden                                                     | Terrain/1     |
| 32800          | Meadow                                                     | Terrain/1     |
| 32900          | Park                                                       | Terrain/1     |
| 35300          | Paludified land                                            | Terrain/1     |
| 35412          | Bog, easy to traverse forested                             | Terrain/1     |
| 35411          | Open bog, easy to traverse treeless                        | Terrain/1     |
| 35421          | Open fen, difficult to traverse treeless                   | Terrain/1     |
| 33000          | Earth fill                                                 | Terrain/1     |
| 33100          | Sports and recreation area                                 | Terrain/1     |
| 36200          | Lake water                                                 | Terrain/1     |
| 36313          | Watercourse area                                           | Terrain/1     |


:::{admonition} Search for files using a pattern
:class: hint

(#search-for-files-using-a-pattern)=
A `pathlib.Path` (such as `DATA_DIRECTORY`) has a handy method to list all
files in a directory (or subdirectories) that match a pattern:
[`glob()`](https://docs.python.org/3/library/pathlib.html#pathlib.Path.glob).
To list all shapefiles in our topographic database directory, we can use the
following expression:

```{code}
(DATA_DIRECTORY / "finland_topographic_database").glob("*.shp")
```

In the search pattern, `?` represents any one single character, `*` multiple
(or none, or one) characters, and `**` multiple characters that can include
subdirectories.

Did you notice the parentheses in the code example above? They work just like
they would in a mathematical expression: first, the expression inside the
parentheses is evaluated, only then, the code outside.
:::


If you take a quick look at the data directory using a file browser, you will
notice that the topographic database consists of *many* smaller files. Their
names follow a strictly defined 
[convention](https://etsin.fairdata.fi/dataset/5023ecc7-914a-4494-9e32-d0a39d3b56ae),
according to this file naming convention, all files that we interested in
(*Terrain/1* and *polygons*) start with a letter `m` and end with a `p`.

We can use the `glob()` pattern search functionality to find those files:

```{code-cell} ipython3
TOPOGRAPHIC_DATABASE_DIRECTORY = DATA_DIRECTORY / "finland_topographic_database"

TOPOGRAPHIC_DATABASE_DIRECTORY
```

```{code-cell} ipython3
list(TOPOGRAPHIC_DATABASE_DIRECTORY.glob("m*p.shp"))
```

(Note that `glob()` returns an iterator, but, for now, we quickly convert
it to a list)

It seems our input data set has only one file that matches our search pattern.
We can save its filename into a new variable, choosing the first item of the
list (index 0):

```{code-cell} ipython3
input_filename = list(TOPOGRAPHIC_DATABASE_DIRECTORY.glob("m*p.shp"))[0] 
```

Now, it’s finally time to open the file and look at its contents:

```{code-cell} ipython3
import geopandas
data = geopandas.read_file(input_filename)
```

First, check the data type of the read data set:

```{code-cell} ipython3
type(data)
```

Everything went fine, and we have a `geopandas.GeoDataFrame`. 
Let’s also explore the data: (1) print the first few rows, and 
(2) list the columns.

```{code-cell} ipython3
data.head()
```

```{code-cell} ipython3
data.columns
```

Oh boy! This data set has many columns, and all of the column names are in
Finnish.

Let’s select a few useful ones and also translate their names to
English. We’ll keep ’RYHMA’ and ’LUOKKA’ (‘group’ and ‘class’, respectively),
and, of course, the `geometry` column.

```{code-cell} ipython3
data = data[["RYHMA", "LUOKKA", "geometry"]]
```

Renaming a column in (geo)pandas works by passing a dictionary to
`DataFrame.rename()`. In this dictionary, the keys are the old names, the values
the new ones:

```{code-cell} ipython3
data = data.rename(
    columns={
        "RYHMA": "GROUP",
        "LUOKKA": "CLASS"
    }
)
```

How does the data set look now?

```{code-cell} ipython3
data.head()
```

:::{admonition} Check your understanding:
:class: hint

Use your pandas skills on this geopandas data set to figure out the following
information:

- How many rows does the data set have?
- How many unique classes?
- ... and how many unique groups?
:::


