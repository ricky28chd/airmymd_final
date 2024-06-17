import 'package:airmymd/app/app.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class WalkThroughWidget extends StatelessWidget {
  const WalkThroughWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalkThroughController>(builder: (_controller) {
      return SafeArea(
        child: SimpleGestureDetector(
          onHorizontalSwipe: _controller.onHorizontalSwipe,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: Visibility(
                            key: ValueKey(walkThrough1()),
                            visible: _controller.walkThroughScreen1,
                            child: walkThrough1(),
                          ),
                        ),

                        ///This AnimatedSwitcher will help in animation white switching the page.
                        AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: Visibility(
                                key: ValueKey(walkThrough2()),
                                visible: _controller.walkThroughScreen2,
                                child: walkThrough2())),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Spacer(),
                              AppSizeBox.height_2,
                              GestureDetector(
                                onTap: _controller.onNextClick,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.22,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    PageConstants.kNext,
                                    style: AppTextStyle.buttonText,
                                  ),
                                ),
                              ),
                              AppSizeBox.height_2,
                              GestureDetector(
                                onTap: () {
                                  _controller.currentPage == 0
                                      ? NavigateTo.goToLoginScreen()
                                      : '';
                                },
                                child: Text(
                                  _controller.currentPage == 0
                                      ? PageConstants.kSkip
                                      : '',
                                  style: TextStyles.whiteMedium17,
                                ),
                              ),
                              AppSizeBox.height_5,
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }
}

///This is the animatedDots which will move according to pages.
Widget buildDot({required int index}) {
  return GetBuilder<WalkThroughController>(builder: (_controller) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 300),
      curve: Curves.slowMiddle,
      height: 7,
      width: _controller.currentPage == index ? 17 : 7,
      decoration: BoxDecoration(
          color: _controller.currentPage == index
              ? AppColors.whiteColor
              : Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(3)),
    );
  });
}

///This is the first walkthrough page.
Widget walkThrough1() {
  return Container(
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage(AppImages.walkthrough1))),
    child: Column(
      children: [
        Spacer(
          flex: 4,
        ),
        const Text(
          PageConstants.kFindYour,
          style: AppTextStyle.introPageSubHeading,
        ),
        AppSizeBox.height_2,
        Text(
          PageConstants.kDoctor,
          style: AppTextStyle.introPageHeading,
        ),
        AppSizeBox.height_5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(2, (index) => buildDot(index: index)),
        ),
        AppSizeBox.height_4,
        Spacer(),
      ],
    ),
  );
}

///This is the second walkthrough page.
Widget walkThrough2() {
  return Container(
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage(AppImages.walkthrough2))),
    child: Column(
      children: [
        Spacer(
          flex: 4,
        ),
        const Text(
          PageConstants.kStoreYourMedical,
          style: AppTextStyle.introPageSubHeading,
        ),
        AppSizeBox.height_2,
        Text(
          PageConstants.kRecords,
          style: AppTextStyle.introPageHeading,
        ),
        AppSizeBox.height_5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(2, (index) => buildDot(index: index)),
        ),
        AppSizeBox.height_4,
        const Spacer(),
      ],
    ),
  );
}
