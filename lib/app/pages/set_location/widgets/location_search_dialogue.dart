import 'package:airmymd/app/app.dart';

class LocationSearchDialog extends StatelessWidget {
  const LocationSearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetLocationController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.locationController.clear();
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_outlined,
                          color: AppColors.textFieldHintText,
                        )),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          controller.autoCompleteSubmit();
                        },
                        style: AppTextStyle.textFieldInput,
                        maxLines: 1,
                        controller: controller.locationController,
                        focusNode: controller.autoLocationFocusNode,
                        textInputAction: TextInputAction.search,
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.streetAddress,
                        onChanged: controller.typeHeadOnchange,
                        decoration: InputDecoration(
                          hintText: 'search for area,street name...',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintStyle: AppTextStyle.textFieldHint,
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.predictionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.asset(
                        AppImages.mapPin,
                        height: Get.height * 0.03,
                      ),
                      title: Text(
                        controller.predictionList[index].description.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.textFieldInput,
                      ),
                      minLeadingWidth: 0,
                      onTap: () {
                        controller.onTapMethod(index);
                      },
                    );
                  })
            ],
          ),
        ),
      );
    });
  }
}
