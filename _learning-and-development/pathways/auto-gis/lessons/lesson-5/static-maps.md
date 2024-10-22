---
title: "Static maps"
permalink: /learning-and-development/pathways/auto-gis/lessons/lesson-5/static-maps/
sidebar:
  nav: "auto-gis"
---


# Static maps

Over the course of the last weeks, we have already become familiar to plotting
basic static maps using
[`geopandas.GeoDataFrame.plot()`](http://geopandas.org/mapping.html), for
instance in lessons [2](../lesson-2/geopandas-an-introduction),
[3](../lesson-3/spatial-join), and [4](../lesson-4/reclassifying-data). We also
learnt that `geopandas.GeoDataFrame.plot()` uses the `matplotlib.pyplot`
library, and that [most of its arguments and options are accepted by
geopandas](https://matplotlib.org/stable/api/pyplot_summary.html).

To refresh our memory about the basics of plotting maps, let’s create a static
accessibility map of the Helsinki metropolitan area, that also shows roads and
metro lines (three layers, overlayed onto each other). Remember that the input
data sets need to be in the same coordinate system!


## Data

We will use three different data sets:
- the travel time to the Helsinki railway station we used in [lesson
  4](../lesson-4/reclassifying-data), which is in `DATA_DIRECTORY /
"helsinki_region_travel_times_to_railway_station"`,
- the Helsinki Metro network, available via WFS from the city’s map services,
  and
- a simplified network of the most important roads in the metropolitan region,
  also available via WFS from the same endpoint.

```{code-cell}
import pathlib
NOTEBOOK_PATH = pathlib.Path().resolve()
DATA_DIRECTORY = NOTEBOOK_PATH / "data"
```

```{code-cell}
import geopandas
import numpy
import ssl
ssl._create_default_https_context = ssl._create_unverified_context

accessibility_grid = geopandas.read_file(
    DATA_DIRECTORY
    / "helsinki_region_travel_times_to_railway_station"
    / "helsinki_region_travel_times_to_railway_station.gpkg"
)
accessibility_grid["pt_r_t"] = accessibility_grid["pt_r_t"].replace(-1, numpy.nan)

WFS_BASE_URL = (
    "https://kartta.hel.fi/ws/geoserver/avoindata/wfs"
    "?service=wfs"
    "&version=2.0.0"
    "&request=GetFeature"
    "&srsName=EPSG:3879"
    "&typeName={layer:s}"
)

metro = (
    geopandas.read_file(
        WFS_BASE_URL.format(layer="avoindata:Seutukartta_liikenne_metro_rata")
    )
    .set_crs("EPSG:3879")
)
roads = (
    geopandas.read_file(
        WFS_BASE_URL.format(layer="avoindata:Seutukartta_liikenne_paatiet")
    )
    .set_crs("EPSG:3879")
)
```


:::{admonition} Coordinate reference systems
:class: attention

Remember that different geo-data frames need to be in same coordinate system
before plotting them in the same map. `geopandas.GeoDataFrame.plot()` does not
reproject data automatically.

You can always check it with a simple `assert` statement.
:::


```{code-cell}
:tags: ["raises-exception"]
assert accessibility_grid.crs == metro.crs == roads.crs, "Input data sets’ CRS differs"
```

If multiple data sets do not share a common CRS, first, figure out which CRS
they have assigned (if any!), then transform the data into a common reference
system:

```{code-cell}
accessibility_grid.crs
```

```{code-cell}
metro.crs
```

```{code-cell}
roads.crs
```

```{code-cell}
roads = roads.to_crs(accessibility_grid.crs)
metro = metro.to_crs(accessibility_grid.crs)
```

```{code-cell}
assert accessibility_grid.crs == metro.crs == roads.crs, "Input data sets’ CRS differs"
```


## Plotting a multi-layer map

:::{admonition} Check your understanding
:class: hint

Complete the next steps at your own pace (clear out the code cells first).
Make sure to revisit previous lessons if you feel unsure how to complete
a task.

- Visualise a multi-layer map using the `geopandas.GeoDataFrame.plot()` method;
- first, plot the accessibility grid using a ‘quantiles’ classification scheme,
- then, add roads network and metro lines in the same plot (remember the `ax`
  parameter)
:::


Remember the following options that can be passed to `plot()`:
- style the polygon layer:
    - define a classification scheme using the `scheme` parameter
    - [change the colour map using
      `cmap`](https://matplotlib.org/stable/tutorials/colors/colormaps.html)
    - control the layer’s transparency the `alpha` parameter (`0` is fully
      transparent, `1` fully opaque)
- style the line layers:
    - adjust [the line
      colour](https://matplotlib.org/stable/api/colors_api.html) using the
      `color` parameter
    - change the `linewidth`, as needed

The layers have different extents (`roads` covers a much larger area). You can
use the axes’ (`ax`) methods `set_xlim()` and `set_ylim()` to set the horizontal
and vertical extents of the map (e.g., to a geo-data frame’s `total_bounds`).



```{code-cell}
ax = accessibility_grid.plot(
    figsize=(12, 8),

    column="pt_r_t",
    scheme="quantiles",
    cmap="Spectral",
    linewidth=0,
    alpha=0.8
)

metro.plot(
    ax=ax,
    color="orange",
    linewidth=2.5
)

roads.plot(
    ax=ax,
    color="grey",
    linewidth=0.8
)

minx, miny, maxx, maxy = accessibility_grid.total_bounds
ax.set_xlim(minx, maxx)
ax.set_ylim(miny, maxy)
```


## Adding a legend

To plot a legend for a map, add the `legend=True` parameter.

For figures without a classification `scheme`, the legend consists of a colour
gradient bar. The legend is an instance of
[`matplotlib.pyplot.colorbar.Colorbar`](https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.colorbar.html),
and all arguments defined in `legend_kwds` are passed through to it. See below
how to use the `label` property to set the *legend title*:

```{code-cell}
ax = accessibility_grid.plot(
    figsize=(12, 8),

    column="pt_r_t",
    cmap="Spectral",
    linewidth=0,
    alpha=0.8,

    legend=True,
    legend_kwds={"label": "Travel time (min)"}
)
```

:::{admonition} Set other `Colorbar` parameters
:class: hint

Check out [`matplotlib.pyplot.colorbar.Colorbar`’s
documentation](https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.colorbar.html)
and experiment with other parameters! Anything you add to the `legend_kwds`
dictionary will be passed to the colour bar.
:::


