# mapsRecollect
Google maps plugin to autocomplete the recollect location metadata field

NOTES:

multiple=>1 on recollect geolocation field can be used

eprintsInterface switch to hide deposit form 
fields and use only the maps drawing manager (99_location_maps.js)

== UPDATE ==

You will need to include the following in the templates/default.xml *after* the <epc:pin ref="head"/>

```   <script type="text/javascript" src="/javascript/99_location_gmap.js"><!--padder--></script> ```
