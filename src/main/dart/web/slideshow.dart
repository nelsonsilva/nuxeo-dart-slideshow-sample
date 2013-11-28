library slideshow_app;

import 'package:route/client.dart';
import 'package:polymer/polymer.dart';
import "search.dart" as nuxeo;
import 'package:nuxeo_automation/client.dart' as nuxeo;

@nuxeo.EntityType("SlideShowElement")
class SlideShowElement {
  String id, type,title, description, thumbnailURL, originalURL, mediumURL;
}

@CustomTag("slideshow-app")
class SlideshowApp extends PolymerElement {

  @observable String tag;

  final nuxeo.Search search = new nuxeo.Search(pageSize: 4, entityType: SlideShowElement);

  // This lets the CSS "bleed through" into the Shadow DOM of this element.
  bool get applyAuthorStyles => true;

  Router router;
  final UrlPattern tagUrl = new UrlPattern(r'(.*)#(.*)');

  SlideshowApp.created() : super.created() {

    // Register our adapters
    nuxeo.BusinessAdapter.register(SlideShowElement);

    // Setup the root
    router = new Router(useFragment: true)
    ..addHandler(new UrlPattern(r'(.*)/index.html'), (_) {}) // default handler
    ..addHandler(tagUrl, (String path) {
      tag = tagUrl.parse(path)[1];
      search.query = "SELECT * FROM Document WHERE ecm:tag = '$tag'";
    })
    ..listen();

  }

  nextPage(event, detail, target) {
    search.nextPage();
  }

  doSearch(event, detail, target) {
    event.preventDefault();
    router.gotoPath("#$tag", tag);
  }

}