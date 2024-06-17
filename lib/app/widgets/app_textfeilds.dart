import 'package:airmymd/app/app.dart';
import 'package:flutter/services.dart';

class GlobalTextField {
  Widget withIcon(
      {bool obscureText = false,
      required String hintText,
      FormFieldValidator<String>? validator,
      ValueChanged<String>? onChanged,
      String? image,
      String? secondImage,
      TextEditingController? controller,
      GestureTapCallback? imageTap,
      String? errorText,
      GestureTapCallback? onTap,
      AlignmentGeometry alignment = Alignment.centerLeft,
      TextInputType? keyBoardType,
      List<TextInputFormatter>? inputFormat,
      TextInputAction? textInputAction,
      bool showCursor = true,
      TextCapitalization textCapitalization = TextCapitalization.none,
      Widget? icon,
      void Function(String?)? onSaved,
      BuildContext? context}) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context!).unfocus(),
        obscureText: obscureText,
        textCapitalization: textCapitalization,
        showCursor: showCursor,
        inputFormatters: inputFormat,
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        onTap: onTap,
        style: AppTextStyle.textFieldInput,
        cursorColor: AppColors.textFieldHintText,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        controller: controller,
        decoration: InputDecoration(
            errorText: errorText,
            prefixIcon: image != null
                ? Align(
                    alignment: alignment,
                    child: GestureDetector(
                      onTap: imageTap,
                      child: Image.asset(
                        image.toString(),
                        errorBuilder: (context, error, stackTrace) {
                          return Container();
                        },
                        width: Get.width * 0.04,
                      ),
                    ),
                  )
                : null,
            suffixIcon: secondImage != null
                ? GestureDetector(
                    onTap: imageTap,
                    child: Image.asset(
                      secondImage.toString(),
                      errorBuilder: (context, error, stackTrace) {
                        return Container();
                      },
                      width: Get.width * 0.04,
                    ),
                  )
                : Container(
                    width: 0,
                  ),
            //contentPadding: EdgeInsets.only(bottom: 3),
            prefixIconConstraints:
                const BoxConstraints(maxWidth: 24, minWidth: 19, maxHeight: 16),
            hintText: hintText,
            hintStyle: AppTextStyle.textFieldHint,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder)),
            icon: icon,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder))),
      ),
    );
  }

  Widget withoutIcon(
      {required String hintText,
      ValueChanged<String>? onChanged,
      TextEditingController? controller,
      String? Function(String?)? validator,
      Widget? suffixIcon,
      String? errorText,
      TextCapitalization textCapitalization = TextCapitalization.none,
      EdgeInsetsGeometry? contentPadding,
      String? initialValue,
      bool? editable,
      TextInputType? keyBoardType,
      List<TextInputFormatter>? inputFormat,
      TextInputAction? textInputAction,
      GestureTapCallback? onTap,
      BuildContext? context}) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        onTapOutside: (text) => Focus.of(context!).unfocus(),
        textCapitalization: textCapitalization,
        enabled: editable,
        initialValue: initialValue,
        style: AppTextStyle.textFieldInput,
        inputFormatters: inputFormat,
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        onTap: onTap,
        cursorColor: AppColors.textFieldHintText,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            contentPadding: contentPadding,
            errorText: errorText,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(maxHeight: Get.height * 0.02),
            hintText: hintText,
            hintStyle: AppTextStyle.textFieldHint,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder))),
      ),
    );
  }

  Widget withLabel(
      {required String hintText,
      ValueChanged<String>? onChanged,
      int maxLines = 1,
      TextEditingController? controller,
      Widget? suffixIcon,
      TextCapitalization textCapitalization = TextCapitalization.none,
      String? errorText,
      EdgeInsetsGeometry? contentPadding,
      String? initialValue,
      bool? editable,
      String? label,
      TextInputType? keyBoardType,
      List<TextInputFormatter>? inputFormat,
      TextInputAction? textInputAction,
      FormFieldValidator<String>? validator,
      BuildContext? context,
      GestureTapCallback? onTap}) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        minLines: 1,
        maxLines: maxLines,
        validator: validator,
        textCapitalization: textCapitalization,
        enabled: editable,
        initialValue: initialValue,
        inputFormatters: inputFormat,
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        onTap: onTap,
        cursorColor: AppColors.textFieldHintText,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: contentPadding,
            errorText: errorText,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(maxHeight: Get.height * 0.02),
            hintText: hintText,
            label: Text(
              label.toString(),
              style: AppTextStyle.textFieldHint,
            ),
            hintStyle: AppTextStyle.textFieldHint,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: AppColors.textFieldBorder,
            )),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: AppColors.textFieldBorder,
            ))),
      ),
    );
  }
}
