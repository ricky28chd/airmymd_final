import 'package:airmymd/app/app.dart';

class SearchDoctor extends StatelessWidget {
  const SearchDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatListController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        width: Get.width * 1,
        height: Get.height * 0.09,
        child: TextFormField(
          keyboardType: TextInputType.name,
          onTap: () {},
          textInputAction: TextInputAction.search,
          //controller: controller.searchByLocationController,
          cursorColor: AppColors.primaryColor,
          textCapitalization: TextCapitalization.sentences,
          style: AppTextStyle.textFieldInput,
          controller: controller.searchFeildController,
          onChanged: (value) => controller.runFilter(value),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                //onTap: controller.fetchCurrentLocation,
                child: Image.asset(AppImages.searchIcon)),
            suffixIconConstraints:
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
            hintText: 'Search By doctor',
            hintStyle: AppTextStyle.textFieldHint,
          ),
        ),
      );
    });
  }
}
