# polygon
Testing whether a point is inside a polygon

Based on `Point in Polygon Strategies`
https://erich.realtimerendering.com/ptinpoly/

## Overpass API/Language Guide
https://wiki.openstreetmap.org/wiki/Overpass_API/Language_Guide#Select_region_by_polygon

## Overpass Tutorial
https://osm-queries.ldodds.com/tutorial/index.html


## osm2mp-garmin-build
https://storage.googleapis.com/google-code-archive-source/v2/code.google.com/osm2mp-garmin-build/source-archive.zip

## Data Extracts - Technical Details
http://download.geofabrik.de/technical.html


## Relation: Novosibirsk (1751445)
https://www.openstreetmap.org/relation/1751445

## Get Relation polygon
https://habr.com/ru/post/463251/<br>
http://polygons.openstreetmap.fr/index.py<br>
<br>
GET	http://polygons.openstreetmap.fr/index.py?id=1751445<br>
GET	http://polygons.openstreetmap.fr/get_geojson.py?id=1751445&params=0<br>
GET	http://polygons.openstreetmap.fr/get_poly.py?id=1751445&params=0<br>
<br>
Generate a simplified polygon<br>
X, Y, Z are parameters for the following postgis equation. The default values are chosen according to the size of the original geometry to give a slighty bigger geometry, without too many nodes.<br>
Note that:<br>
    X > 0 will give a polygon bigger than the original geometry, and guaranteed to contain it.<br>
    X = 0 will give a polygon similar to the original geometry.<br>
    X < 0 will give a polygon smaller than the original geometry, and guaranteed to be smaller.<br>
http://polygons.openstreetmap.fr/get_poly.py?id=1751445&params=0.000100-0.000100-0.000100<br>
http://polygons.openstreetmap.fr/get_poly.py?id=1751445&params=0.000200-0.000200-0.000200<br>
http://polygons.openstreetmap.fr/get_poly.py?id=1751445&params=0.004000-0.001000-0.001000<br>
<br>
https://wiki.openstreetmap.org/wiki/Downloading_data<br>

## Download OSM data throuh Overpass API
https://overpass-api.de/api/map?bbox=80.952,53.494,85.116,56.060

## Download OSM data from overpass-api
!wget -O 00400240.osm https://overpass-api.de/api/map?bbox=80.9517245,53.4943074,85.1159569,56.0598686<br>
!wget -O 00400241.osm https://overpass-api.de/api/map?bbox=80.9517245,53.4943074,85.1159569,56.0598686<br>
<br>
## Download speedcamonline
https://speedcamonline.ru/index.php?map_selected=Rus&double=&e0=on&e3=on&e12=on&e14=on&e11=on&e110=on&e5=on&e2=on&e1=on&e17=on&e16=on&e8=on&e9=on&e7=on&e10=on&e6=on&e206=on&e207=on&e208=on&e999=on&filter_id=&region=42&cam_adress=&cam_N=&cam_E=&cam_source=&dir_type=-1&dir_lock=-1&sort=adress&submit=+%D4%E8%EB%FC%F2%F0%EE%E2%E0%F2%FC+<br>
<br>
https://speedcamonline.ru/igo/Rus&region=42&kind_list=1000,0,3,12,14,11,110,5,2,1,16,8,9,7,10<br>
<br>
https://speedcamonline.ru/igo/Rus&region=42&kind_list=1000,0,3,12,14<br>
https://speedcamonline.ru/igo/Rus&region=42&kind_list=1000,11,110,5,2,1<br>
https://speedcamonline.ru/igo/Rus&region=42&kind_list=1000,8,9,7,10<br>
