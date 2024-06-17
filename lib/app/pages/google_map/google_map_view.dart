import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/google_map/widgets/doc_list_search_dialogue.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleScreenController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              controller.specialization,
              style: TextStyles.darkWhite20,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                    onTap: controller.showDoctorsList,
                    child: controller.showMapView.value == true
                        ? const Icon(
                            Icons.format_list_bulleted_rounded,
                            color: AppColors.whiteColor,
                            size: 35,
                          )
                        : Center(
                            child: Image.asset(
                            AppImages.navMapIcon,
                            height: Get.height * 0.03,
                          ))),
              )
            ],
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: _searchDoctorByLocation())),
        body: const GoogleMapWidget(),
      );
    });
  }
}

Widget _searchDoctorByLocation() {
  return GetBuilder<GoogleScreenController>(builder: (controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      width: Get.width * 1,
      height: Get.height * 0.09,
      child: TextFormField(
        keyboardType: TextInputType.none,
        onTap: () => Get.dialog(const DoctorListLocationSearchDialog()),
        onFieldSubmitted: (String value) {},
        textInputAction: TextInputAction.search,
        controller: controller.userCurrentLocation,
        cursorColor: AppColors.primaryColor,
        textCapitalization: TextCapitalization.sentences,
        style: AppTextStyle.textFieldInput,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: controller.fetchCurrentLocation,
              child: Image.asset(AppImages.currentLocationIcon)),
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 20, maxWidth: 40, minWidth: 40),
          prefixIcon: Image.asset(AppImages.iconLocationBlack),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 20, maxWidth: 40, minWidth: 40),
          filled: true,
          fillColor: AppColors.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          hintText: 'Search By Location',
          hintStyle: AppTextStyle.textFieldHint,
        ),
      ),
    );
  });
}
