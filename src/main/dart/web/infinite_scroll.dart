library infinite_scroll;

import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag("infinite-scroll")
class InfiniteScroll extends DivElement with Polymer, Observable {

  @published int distance = 0;
  @published bool enabled = true;
  bool _checkWhenEnabled = false;
  var scrollEvtSubscription;

  InfiniteScroll.created() : super.created() {
    scrollEvtSubscription = window.onScroll.listen(_handler);
    _handler();
  }

  // This lets the CSS "bleed through" into the Shadow DOM of this element.
  bool get applyAuthorStyles => true;

  leftView() {
    scrollEvtSubscription.cancel();
  }

  enabledChanged() {
    if (enabled && _checkWhenEnabled) {
      _checkWhenEnabled = false;
      _handler();
    }
  }

  _handler([_]) {
    var windowBottom = window.innerHeight + window.scrollY,
        elementBottom = offsetTop + clientHeight,
        remaining = elementBottom - windowBottom,
        shouldScroll = (remaining <= window.innerHeight * distance);

    if (shouldScroll) {
      if (enabled) {
        dispatchEvent(new CustomEvent("scrolling"));
      } else {
        _checkWhenEnabled = true;
      }
    }
  }
}