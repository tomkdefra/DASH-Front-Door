---
title: "Spatial join"
permalink: /learning-and-development/pathways/auto-gis/lessons/lesson-3/spatial-join/
sidebar:
  nav: "auto-gis"
---


# Spatial join

*Spatial joins* are operations that combine data from two or more spatial data
sets based on their geometric relationship. In the previous sections, we got to
know two specific cases of spatial joins: [Point-in-polygon
queries](point-in-polygon-queries) and [intersects-queries](intersect). However,
there is more to using the geometric relationship between features and between
entire layers.

Spatial join operations require two input parameters: the *predicament*, i.e., the
geometric condition that needs to be met between two geometries, and the
*join-type*: whether only rows with matching geometries are kept, or all of one
input table’s rows, or all records. 

*Geopandas* (using `shapely` to implement geometric relationships) [supports a
standard set of geometric
predicates](https://geopandas.org/en/stable/docs/user_guide/mergingdata.html#binary-predicate-joins),
that is similar to most GIS analysis tools and applications:

- intersects
- contains
- within
- touches
- crosses
- overlaps

Geometric predicaments are expressed as verbs, so they have an intuitive
meaning. See the [shapely user
manual](https://shapely.readthedocs.io/en/stable/manual.html#binary-predicates)
for a detailed description of each geometric predicate.


:::{admonition} Binary geometric predicates
:class: hint

Shapely supports more *binary geometric predicates* than geopandas implements
for spatial joins. What are they? Can they be expressed by combining the
implemented ones?
:::


In terms of the *join-type*, geopandas implements three different options:

- *left*: keep all records of the *left* data frame, fill with empty values if
  no match, keep *left* geometry column
- *right*: keep all records of the *left* data frame, fill with empty values if
  no match, keep *right* geometry column
- *inner*: keep only records of matching records, keep *left* geometry column


:::{tip}
The [PyGIS
book](https://pygis.io/docs/e_spatial_joins.html) has a great overview of
spatial predicaments and join-types with explanatory drawings.
:::




```{code-cell}
population_grid.head()
```

The population grid has many columns, and all of its column names are in
Finnish. Let’s drop (delete) all of the columns except the population total,
and rename the remaining to English:

```{code-cell}
population_grid = population_grid[["asukkaita", "geometry"]]
population_grid = population_grid.rename(columns={"asukkaita": "population"})
```

Finally, calculate the population density by dividing the number of inhabitants
of each grid cell by its area in km²:

```{code-cell}
population_grid["population_density"] = (
    population_grid["population"]
    / (population_grid.area / 1_000_000)
)
population_grid.head()
```

:::{admonition} Coding style: big numbers, operators in multi-line expressions
:class: tip

If you need to use very large numbers, such as, in the above example, the *1
million* to convert m² to km², you can use underscore characters (`_`) as
thousands separators. The Python interpreter will treat a sequence of numbers
interleaved with underscores as a regular numeric value.
[You can use the same syntax to group
numbers](https://peps.python.org/pep-0515/) by a different logic, for instance,
to group hexadecimal or binary values into groups of four.

In case an expression, such as, e.g., a mathematical formula, spreads across
multiple lines, it is considered good coding style to place an operator at the
beginning of a new line, rather than let it trail in the previous line. This is
considered more readable, as explained in the [PEP-8 styling
guidelines](https://peps.python.org/pep-0008/#should-a-line-break-before-or-after-a-binary-operator)
:::




As a final task, let’s look at how to plot data using a *graduated*
cartographic visualisation scheme. 

The `geopandas.GeoDataFrame.plot()` method can vary the map colours depending on a column’s values by passing its name as a named argument `column`. On top of that, the method accepts many arguments to influence the style of the map. Among them are `scheme` and `cmap` that define the [categorisation scheme](https://geopandas.org/en/stable/gallery/choropleths.html), and the [colour map](https://matplotlib.org/stable/tutorials/colors/colormaps.html) used. Many more arguments are passed through to `matplotlib`, such as `markersize` to set the size of point symbols, and `facecolor` to set the colour of polygon areas. To draw a legend, set `legend` to `True`, to set the size of the figure, pass a tuple (with values in inch) as `figsize`.

```{code-cell}
ax = addresses_with_population_data.plot(
    figsize=(10, 10),
    column="population_density",
    cmap="Reds",
    scheme="quantiles",
    markersize=15,
    legend=True
)
ax.set_title("Population density around address points")
```




Finally, remember to save the output data frame to a file. We can append it to
the existing *GeoPackage* by specifying a new layer name:

```{code-cell}
addresses_with_population_data.to_file(
    DATA_DIRECTORY / "addresses.gpkg",
    layer="addresses_with_population_data"
)
