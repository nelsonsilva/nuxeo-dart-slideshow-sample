# nuxeo-dart-slideshow-sample
[![Build Status](https://drone.io/github.com/nelsonsilva/nuxeo-dart-slideshow-sample/status.png)](https://drone.io/github.com/nelsonsilva/nuxeo-dart-slideshow-sample/latest)

This is a port of the original [nuxeo-slideshow-sample](https://github.com/dmetzler/nuxeo-slideshow-sample) to Dart.

It's a very simple application that makes use of Nuxeo and Dart to show pictures. 

UI is a tag based search UI : you type a tag, click the search button... that's it !

This sample make use of the BusinessObject adapter exposed thru Nuxeo Rest API.

## Try it

In order to install it, you have to :

 * Download and Run a recent Nuxeo distribution (>= 5.8)

 * Download the prebuilt bundle [nuxeo-dart-slideshow-sample-1.0-SNAPSHOT.jar](https://drone.io/github.com/nelsonsilva/nuxeo-dart-slideshow-sample/files/target/nuxeo-dart-slideshow-sample-1.0-SNAPSHOT.jar) to the `$NUXEO_HOME/nxserver/bundles` folder
 
 * Launch Nuxeo
 
 * The application should be available at [http://localhost:8080/nuxeo/slideshow/]()

## How to build

In order to build, you have to :

 * install [Dart](http://dartlang.org/)

 * Add the Dart SDK `bin` folder to your PATH

 * Download and Run a recent Nuxeo distribution (>= 5.8)
 
 * clone this repository
 
 * launch `mvn clean install`

 * copy the target/nuxeo-dart-slideshow-sample*.jar in the `$NUXEO_HOME/nxserver/bundles` folder
 
 * Launch Nuxeo
 
 * The application should be available at [http://localhost:8080/nuxeo/slideshow/]()
 
 
## How to hack
 * The application is made of two parts :
 	* a nuxeo server running on port 8080
 	* a frontend Dart app that can be served by Nuxeo or by pub serve. 


If you want to hack the frontend app you'll have to add a CORS config contribution to allow Dartium to do cross-domain requests to your Nuxeo server:

```xml
<?xml version="1.0"?>
<component name="org.nuxeo.ecm.platform.web.dart.tck">
  <extension target="org.nuxeo.ecm.platform.web.common.requestcontroller.service.RequestControllerService" point="corsConfig">
    <corsConfig name="dartTCK" allowOrigin="http://127.0.0.1:3030">
      <pattern>/nuxeo/api/.*</pattern>
      <pattern>/nuxeo/site/automation/.*</pattern>
    </corsConfig>
  </extension>
</component>
```
## Tributes

Kudos to [Laurent Doguin](https://github.com/ldoguin) and [Damien Metzler](https://github.com/dmetzler) for the initial implementation.
