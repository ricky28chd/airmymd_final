import 'package:get/get.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../../app.dart';

class WalkThroughController extends GetxController {
  ///This will check if the page is initial or second one.
  var currentPage = 0;

  ///This is the visibility status of both walkThrough pages.
  bool walkThroughScreen1 = true;
  bool walkThroughScreen2 = false;

  ///This function will turn second page visible and first
  ///one will gonna hide at the same time
  void onNextClick() {
    if (walkThroughScreen1 == true) {
      walkThroughScreen1 = false;
      walkThroughScreen2 = true;
    } else {
      walkThroughScreen2 = true;
      walkThroughScreen1 = false;
    }
    currentPage == 0 ? currentPage = 1 : currentPage==1?NavigateTo.goToLoginScreen():currentPage=1;
    update();
  }

  ///onHorizontalSwipe function comes from third party package and will detect left right swipe.
  ///on left swipe first page will appear and second one will hide.
  ///on right swipe it will work vice versa.
  void onHorizontalSwipe(SwipeDirection direction) {
    if (direction == SwipeDirection.left) {
      if (walkThroughScreen1 == true) {
        walkThroughScreen1 = false;
        walkThroughScreen2 = true;
      } else {
        walkThroughScreen2 = true;
        walkThroughScreen1 = false;
      }
      currentPage == 0 ? currentPage = 1 : currentPage = 1;
      print('Swiped left!');
    } else {
      if (walkThroughScreen2 == true) {
        walkThroughScreen2 = false;
        walkThroughScreen1 = true;
      } else {
        walkThroughScreen1 = true;
        walkThroughScreen2 = false;
      }
      currentPage == 1 ? currentPage = 0 : currentPage = 0;
      print('Swiped right!');
    }

    ///In Getx this update function is used to update something.
    update();
  }
}
