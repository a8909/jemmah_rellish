import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Scroller {
  final ScrollController scrollController = ScrollController();
  bool hideBottomsheet = false;
  set bottomSheetPhysics(bool bottomPhysics) {
    hideBottomsheet = bottomPhysics;
  }

  bool get scroll => hideBottomsheet;

  onScroll() {
    scrollController.addListener(onScrollPhysics());
  }

  onScrollPhysics() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      //show
      bottomSheetPhysics = true;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      //hide
      bottomSheetPhysics = false;
    }
  }
}
