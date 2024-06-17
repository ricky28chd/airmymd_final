import 'package:airmymd/app/app.dart';

class AddNewCardWidget extends StatelessWidget {
  const AddNewCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AddNewCardController>(builder: (controller) {
        return SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              AppSizeBox.height_3,
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Image.asset(
                        controller.cardImage,
                        scale: 0.6,
                      ))),
              SingleChildScrollView(
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  height: Get.height * 0.87,
                  width: Get.width * 1,
                  alignment: Alignment.bottomCenter,
                  child: addCardWidget(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
