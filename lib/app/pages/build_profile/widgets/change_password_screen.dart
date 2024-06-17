// import 'package:airmymd/app/app.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({Key? key}) : super(key: key);
  
//   @override
//   // ignore: library_private_types_in_public_api
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<BuildProfileController>(builder: (controller) {
//       return Scaffold(
//         appBar: AppBar(
//           shadowColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//           title: const Text(
//             'Change Password',
//             style: AppTextStyle.appBarHeading,
//           ),
//           backgroundColor: AppColors.primaryColor,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: AppPadding.outerScreenPadding,
//             child: Column(
//               children: [
//                 AppSizeBox.height_5,
//                 // Obx(
//                 //   () => GlobalTextField().withLabel(
//                 //     textInputAction: TextInputAction.next,
//                 //     keyBoardType: TextInputType.name,
//                 //     label: 'Old Password',
//                 //     hintText: 'Old Password',
//                 //     textCapitalization: TextCapitalization.words,
//                 //     controller: controller.oldPasswordController,
//                 //     onChanged: controller.enterOldPassword,
//                 //     errorText: controller.oldPasswordError.value == ''
//                 //         ? null
//                 //         : controller.oldPasswordError.value,
//                 //   ),
//                 // ),
//                 Obx( () => 
//                    GlobalTextField().withLabel(
//                     textInputAction: TextInputAction.next,
//                     keyBoardType: TextInputType.name,
//                     textCapitalization: TextCapitalization.words,
//                     label: 'New Password',
//                     hintText: 'New Password',
//                     controller: controller.newPasswordController,
//                     onChanged: controller.enterNewPassword,
//                     errorText: controller.newPasswordError.value == ''
//                         ? null
//                         : controller.newPasswordError.value,
//                   ),
//                 ),
//                 // Obx(
//                 //   () => GlobalTextField().withLabel(
//                 //     textInputAction: TextInputAction.next,
//                 //     keyBoardType: TextInputType.name,
//                 //     textCapitalization: TextCapitalization.words,
//                 //     label: 'Confirm New Password',
//                 //     hintText: 'Confirm New Password',
//                 //     controller: controller.confirmNewPasswordController,
//                 //     onChanged: controller.enterConfirmNewPassword,
//                 //     errorText: controller.confirmNewPasswordError.value == ''
//                 //         ? null
//                 //         : controller.confirmNewPasswordError.value,
//                 //   ),
//                 // ),
//                 AppSizeBox.height_10,
//                 buildChangePasswordScreenButton(context),
//                 AppSizeBox.height_5,
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
