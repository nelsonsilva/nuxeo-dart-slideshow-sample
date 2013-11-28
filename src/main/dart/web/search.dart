library search;

import 'package:nuxeo_automation/browser_client.dart' as nuxeo;
import 'package:observe/observe.dart';

class Search extends Observable {

  final List items = toObservable([]);

  @observable bool busy = false;
  @observable bool isNextPageAvailable = true;
  @observable int currentPageIndex = 0;

  String _query;

  int pageSize = 20;

  Type entityType;

  static final String nuxeoUrl = "/nuxeo";
  nuxeo.Client nx;

  Search({String query, this.pageSize: 4, this.entityType}) {
    nx = new nuxeo.Client(url: nuxeoUrl);
    if (query != null) {
      this.query = query;
    }
  }

  get query => _query;
  set query(q) {
    _query = notifyPropertyChange(#query, _query, q);
    // Execute the query immediately
    items.clear();
    currentPageIndex = 0;
    isNextPageAvailable = true;
    busy = false;
    nextPage();
  }

  nextPage() {

    if (query.isEmpty) {
      //$q.reject("You need to set a query")
      return;
    }

    if (!isNextPageAvailable || busy)
      return;

    busy = true;

    var req = nx.doc("/").search(query: query, pageSize: pageSize, currentPageIndex: currentPageIndex);

    if (entityType != null) {
      req.bo(entityType);
    }

    req.fetch()
    .then((nuxeo.Pageable results) {
      currentPageIndex = results.currentPageIndex + 1;
      isNextPageAvailable = results.isNextPageAvailable;
      results.forEach((result) { items.add(result); });
      busy = false;
    });
  }
}