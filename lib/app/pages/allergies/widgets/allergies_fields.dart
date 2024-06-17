import 'package:airmymd/app/app.dart';

Widget reactionField(
    {required TextEditingController drugController,
    required TextEditingController commentController}) {
  return GetBuilder<AllergiesController>(builder: (controller) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalTextField().withoutIcon(
            hintText: 'Drug Name',
            controller: drugController,
            errorText: controller.nameControllerListError == ''
                ? null
                : controller.nameControllerListError,
          ),
          GlobalTextField().withoutIcon(
            hintText: 'Reaction/Comment',
            controller: commentController,
            errorText: controller.commentControllerListError == ''
                ? null
                : controller.commentControllerListError,
          ),
        ],
      ),
    );
  });
}

Widget allergiesField(
    {required TextEditingController foodNameController,
    required TextEditingController commController}) {
  return GetBuilder<AllergiesController>(builder: (controller) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalTextField().withoutIcon(
            hintText: 'Food Name',
            controller: foodNameController,
          ),
          GlobalTextField().withoutIcon(
            hintText: 'Reaction/Comment',
            controller: commController,
          ),
        ],
      ),
    );
  });
}
