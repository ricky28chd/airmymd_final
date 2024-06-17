import 'package:airmymd/app/app.dart';

class GlobalDropDown extends StatelessWidget {
  const GlobalDropDown({
    this.dropDownItem,
    this.onChanged,
    required this.items,
    required this.hintText,
    this.errorText,
  });
  final String? dropDownItem;
  final ValueChanged? onChanged;
  final List<String> items;
  final String hintText;
  final String? errorText;
  // final List<DropdownMenuItem<String>> ?dropDownItemsList;

  ///This is the function to fetch data from
  ///list using for loop and it will add new items as well.
  List<DropdownMenuItem<String>> getDropdownItems(
      {required List<String> dropDownItemName}) {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < dropDownItemName.length; i++) {
      String dropDownInputText = dropDownItemName[i];
      var newItem = DropdownMenuItem(
        value: dropDownInputText,
        child: Text(
          dropDownInputText,
          style: AppTextStyle.textFieldInput,
          maxLines: 3,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  ///function ends here.
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
            menuMaxHeight: Get.height * 0.30,
            borderRadius: BorderRadius.circular(10),
            decoration: InputDecoration(
                errorText: errorText,
                label: Text(
                  hintText,
                  style: AppTextStyle.textFieldHint,
                ),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textFieldBorder)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textFieldBorder))),
            alignment: Alignment.centerLeft,
            hint: Text(
              hintText,
              style: AppTextStyle.textFieldHint,
            ),
            //dropdownColor: AppColors.primaryColor,
            icon: Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      AppImages.expandMore,
                      height: Get.height * 0.008,
                    ))),
            value: dropDownItem,
            isExpanded: true,
            items: getDropdownItems(
              dropDownItemName: items,
            ),
            onChanged: onChanged),
      ),
    );
  }
}
