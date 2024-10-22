---
title: "Map projections"
permalink: /learning-and-development/pathways/auto-gis/lessons/lesson-2/map-projections/
sidebar:
  nav: "auto-gis"
---


# Map projections

A **coordinate reference systems (CRS)** is a crucial piece of metadata for any
geospatial data set. Without a CRS, the geometries would simply be a collection
of coordinates in an arbitrary space. Only the CRS allows GIS software,
including the Python packages we use in this course, to relate these
coordinates to a place on Earth (or other approximately spherical objects or
planets).

Often conflated with coordinate reference systems, and definitely closely
related, are **map projections**. Map projections, also called *projected
coordinate systems*, are mathematical models that allow us to transfer
coordinates on the surface of our **three-dimensional Earth** into coordinates
in a planar surface, such as a **flat, two-dimensional map**. In contrast to
projected coordinate systems, *geographic coordinate systems* simply directly
use latitude and longitude, i.e. the degrees along the horizontal and vertical
great circles of a sphere approximating the Earth, as the x and y coordinates
in a planar map. Finally, there are both projected and geographic coordinate
systems that make use of more complex ellipsoids than a simple sphere to better
approximate the ‘potato-shaped’ reality of our planet. The full CRS information
needed to accurately relate geospatial information to a place on Earth includes
both (projected/geographic) coordinate system and ellipsoid.

The CRS in different spatial datasets differ fairly often, as different
coordinate systems are optimised for certain regions and purposes. No
coordinate system can be perfectly accurate around the globe, and the
transformation from three- to two-dimensional coordinates can not be accurate
in angles, distances, and areas simultaneously.

Consequently, it is a common GIS task to **transform** (or reproject) a data
set from one references system into another, for instance, to make two layers
interoperatable. Comparing two data sets that have different CRS would
inevitably produce wrong results; for example, finding points contained within
a polygon cannot work, if the the points have geographic coordinates (in
degrees), and the polygon is in the national Finnish reference system (in
meters).

Choosing an appropriate projection for your map is not always straightforward.
It depends on what you actually want to represent in your map, and what your
data’s spatial scale, resolution and extent are. In fact, there is not a single
‘perfect projection’; each has strengths and weaknesses, and you should choose
a projection that fits best for each map. In fact, the projection you choose
might even tell something about you:


:::{figure} https://imgs.xkcd.com/comics/map_projections.png
:alt: What’s that?  You think I don’t like the Peters map because I’m uncomfortable with having my cultural assumptions challenged? Are you sure you’re not ... *puts on sunglasses* ... projecting?

The XKCD web comic had it figured out long ago: ‘What your favourite map
projection tells about you’. *Source: [xkcd.com](https://xkcd.com/977)*

:::
    

:::{note}

For those of you who prefer a more analytical approach to choosing map
projections: you can get a good overview from
[georeference.org](http://www.georeference.org/doc/guide_to_selecting_map_projections.htm),
and this blog post discussing [the strengths and weaknesses of a few commonly
used projections](http://usersguidetotheuniverse.com/index.php/2011/03/03/whats-the-best-map-projection/).
The web page *Radical Cartography* has an excellent [overview of which
projections fit which extent of the world for which
topic](https://radicalcartography.net/projectionref.html).

:::




### Reprojecting a `GeoDataFrame` 

A geographic coordinate system, `EPSG:4326`, is not particularly well-suited
for showing the countries of the European Union. Distortion is high. Rather, we
could use a *Lambert Azimuthal Equal-Area* projection, such as
[`EPSG:3035`](https://spatialreference.org/ref/epsg/etrs89-etrs-laea/), the map
projection [officially recommended by the European
Commission](http://mapref.org/LinkedDocuments/MapProjectionsForEurope-EUR-20120.pdf).

[Transforming data from one reference system to another is a very simple task
in geopandas](http://geopandas.org/projections.html#re-projecting). In fact,
all you have to to is use the `to_crs()` method of a `GeoDataFrame`, supplying
a new CRS in a wide range of possible formats. The easiest is to use an EPSG
code:

```{code-cell}
eu_countries_EPSG3035 = eu_countries.to_crs("EPSG:3035")
```

Let’s check how the coordinate values have changed:

```{code-cell}
eu_countries_EPSG3035.geometry.head()
```

And here we go, the coordinate values in the geometries have changed!
Congratulations on carrying out your very first geopandas coordinate
transformation!

To better grasp what exactly we have just done, it is a good idea to explore
our data visually.  Let’s plot our data set both before and after the
coordinate transformation. We will use `matplotlib`’s `subplots` feature that
we got to know in [Geo-Python
lesson 7](https://geo-python-site.readthedocs.io/en/latest/notebooks/L7/advanced-plotting.html).


```{code-cell}
import matplotlib.pyplot

# Prepare sub plots that are next to each other
figure, (axis1, axis2) = matplotlib.pyplot.subplots(nrows=1, ncols=2)

# Plot the original (WGS84, EPSG:4326) data set
eu_countries.plot(ax=axis1)
axis1.set_title("WGS84")
axis1.set_aspect(1)

# Plot the reprojected (EPSG:3035) data set
eu_countries_EPSG3035.plot(ax=axis2)
axis2.set_title("ETRS-LAEA")
axis2.set_aspect(1)

matplotlib.pyplot.tight_layout()
```


Indeed, the maps look quite different, and the re-projected data set distorts
the European countries less, especially in the Northern part of the continent.

Let’s still save the reprojected data set in a file so we can use it later.
Note that, even though modern file formats save the CRS reliably, it is a good
idea to use a descriptive file name that includes the reference system
information.

```{code-cell}
eu_countries_EPSG3035.to_file(
    DATA_DIRECTORY / "eu_countries" / "eu_countries_EPSG3035.gpkg"
)
```




# Global map projections

Finally, it’s time to play around with some map projections. For this, you will
find a global data set of country polygons in the data directory. It was
downloaded from [naturalearthdata.com](https://naturalearthdata.com/), a
fantastic resource for cartographer-grade geodata.


:::{admonition} Check your understanding
:class: attention

Read in the data set from `DATA_DIRECTORY / "world_countries" /
"ne_110m_admin_0_countries.zip"` and plot three maps with different map
projections. You can use the hints and definitions from the following resources
(and anywhere else):

- [geopandas.org/projections.html](http://geopandas.org/projections.html)
- [pyproj4.github.io](https://pyproj4.github.io/pyproj/dev/api/crs.html)
- [spatialreference.org](https://spatialreference.org/)

While plotting the maps and choosing map projections, think about the
advantages and disavantages of different map projections.
:::


```{code-cell}
world_countries = geopandas.read_file(
    DATA_DIRECTORY / "world_countries" / "ne_110m_admin_0_countries.zip"
)
```

```{code-cell}
world_countries.plot()
matplotlib.pyplot.title(world_countries.crs.name)
```

```{code-cell}
# web mercator
world_countries_EPSG3857 = world_countries.to_crs("EPSG:3857")

world_countries_EPSG3857.plot()
matplotlib.pyplot.title(world_countries_EPSG3857.crs.name)

# remove axis decorations
matplotlib.pyplot.axis("off")
```

```{code-cell}
# Eckert-IV (https://spatialreference.org/ref/esri/54012/)
ECKERT_IV = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"

world_countries_eckert_iv = world_countries.to_crs(ECKERT_IV)
world_countries_eckert_iv.plot()
matplotlib.pyplot.title("Eckert Ⅳ")
matplotlib.pyplot.axis("off")
```

```{code-cell}
# An orthographic projection, centered in Finland!
# (http://www.statsmapsnpix.com/2019/09/globe-projections-and-insets-in-qgis.html)
world_countries_ortho = world_countries.to_crs(
    "+proj=ortho +lat_0=60.00 +lon_0=23.0000 +x_0=0 +y_0=0 "
    "+a=6370997 +b=6370997 +units=m +no_defs"
)
world_countries_ortho.plot()
matplotlib.pyplot.axis("off")
```
